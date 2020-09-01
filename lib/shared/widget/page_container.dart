import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:women_fitness_flutter/ad/ad_utils.dart';
import 'package:women_fitness_flutter/db/hive/admob_fitness.dart';

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

    var adsBox = Hive.box('admob_fitness');
    AdmobFitness admobFitness = adsBox.get(AdUtils.bannerLoaded);
    isLoadAds = admobFitness.isLoaded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Container(
        margin: isLoadAds
            ? EdgeInsets.only(bottom: 50)
            : EdgeInsets.only(bottom: 0),
        child: widget.child,
      ),
    );
  }
}
