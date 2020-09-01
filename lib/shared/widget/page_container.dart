import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:women_fitness_flutter/ad/ad_utils.dart';
import 'package:women_fitness_flutter/db/hive/admob_fitness.dart';
import 'package:women_fitness_flutter/db/hive/iap_fitness.dart';

class PageContainer extends StatefulWidget {
  final Widget child;
  final PreferredSizeWidget appBar;

  PageContainer({this.child, this.appBar});

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  bool isLoadAds;

  @override
  void initState() {
    super.initState();

    var iapBox = Hive.box('iap_fitness');
    IAPFitness iapFitness = iapBox.get("premium");
    isLoadAds = iapFitness.isBuy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Container(
        margin: isLoadAds
            ? EdgeInsets.only(bottom: 0)
            : EdgeInsets.only(bottom: 50),
        child: widget.child,
      ),
    );
  }
}
