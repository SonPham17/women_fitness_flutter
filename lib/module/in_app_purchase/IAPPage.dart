import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class IAPPage extends StatefulWidget {
  @override
  _IAPPageState createState() => _IAPPageState();
}

class _IAPPageState extends State<IAPPage> {
  final String forever = "forever";
  final String month = "1_month";
  final String year = "1_year";

  Set<String> ids = Set.from(["forever", "1_month", "1_year"]);

  InAppPurchaseConnection _appPurchaseConnection =
      InAppPurchaseConnection.instance;
  bool _available = true;

  List<ProductDetails> _products = [];

  List<PurchaseDetails> _purchases = [];

  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    _available = await _appPurchaseConnection.isAvailable();
    if (_available) {
      await _getProducts();
      await _getPastPurchases();

//      _verifyPurchase();

      _subscription =
          _appPurchaseConnection.purchaseUpdatedStream.listen((data) {
        print('new purchase= ${data.length}');
        _appPurchaseConnection.completePurchase(data[0]);
        _purchases.addAll(data);
        _verifyPurchase();
      }, onDone: () {
        _subscription.cancel();
      });
    }
  }

  Future<void> _getProducts() async {
    ProductDetailsResponse response =
        await _appPurchaseConnection.queryProductDetails(ids);

    setState(() {
      _products = response.productDetails;
    });
  }

  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response =
        await _appPurchaseConnection.queryPastPurchases();

    print('length past purchase= ${response.pastPurchases.length}');

    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        _appPurchaseConnection.completePurchase(purchase);
      }
    }

    _purchases = response.pastPurchases;
  }

  PurchaseDetails _hasPurchased(String productID) {
    return _purchases.firstWhere((purchase) => purchase.productID == productID,
        orElse: () => null);
  }

  void _verifyPurchase() {
    PurchaseDetails purchase = _hasPurchased('forever');

    if (purchase != null && purchase.status == PurchaseStatus.purchased) {
      print('da mua ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/crown.svg',
                    width: 50,
                    color: Colors.white,
                    height: 50,
                  ),
                  TextApp(
                    content: S.current.iap_premium,
                    textColor: Colors.white,
                    size: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextApp(
                                content: S.current.iap_remove.toUpperCase(),
                                textColor: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextApp(
                                content: S.current.iap_unlimited.toUpperCase(),
                                textColor: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) => InkWell(
                onTap: () {
                  PurchaseParam purchaseParam = PurchaseParam(
                      productDetails: _products[index],
                      applicationUserName: null,
                      sandboxTesting: true);
                  if (index == 0) {
                    _appPurchaseConnection.buyNonConsumable(
                      purchaseParam: purchaseParam,
                    );
                  } else {
                    _appPurchaseConnection.buyConsumable(
                        purchaseParam: purchaseParam);
                  }
                },
                child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index == 0
                          ? Colors.orange
                          : (index == 1 ? Colors.blue : Colors.lightGreen),
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/premium.svg',
                          width: 40,
                          height: 40,
                          color: index == 0
                              ? Colors.yellow
                              : (index == 1 ? Colors.brown : Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextApp(
                                textColor: Colors.white,
                                size: 23,
                                content:
                                    '${_products[index].price} (${index == 0 ? 'forever' : (index == 1 ? '/1 month' : '/3 months')})',
                              ),
                              TextApp(
                                content: _products[index].description,
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              itemCount: _products.length,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
