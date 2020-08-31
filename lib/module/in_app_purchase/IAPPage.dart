import 'dart:async';

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

  StreamSubscription _subscription;

  int _credits = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    _available = await _appPurchaseConnection.isAvailable();
    if (_available) {
      await _getListSanPham();

      _subscription =
          _appPurchaseConnection.purchaseUpdatedStream.listen((data) {
        print('new purchase= $data');
      });
    }
  }

  Future<void> _getListSanPham() async {
    _appPurchaseConnection.queryProductDetails(ids).then((value) {
      var data = value.productDetails;
      print(data);
    });
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
            FutureBuilder<ProductDetailsResponse>(
              future: _appPurchaseConnection.queryProductDetails(ids),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return TextApp(
                      content: 'Loading....',
                    );
                  default:
                    if (snapshot.hasError)
                      return TextApp(
                        content: 'Error: ${snapshot.error}',
                      );
                    else
                      return Text('Result: ${snapshot.data.productDetails}');
                }
              },
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
