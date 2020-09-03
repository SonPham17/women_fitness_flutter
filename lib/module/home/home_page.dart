import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/ad/ad_manager.dart';
import 'package:women_fitness_flutter/ad/ad_task.dart';
import 'package:women_fitness_flutter/db/hive/admob_fitness.dart';
import 'package:women_fitness_flutter/db/hive/iap_fitness.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/home/home_bloc.dart';
import 'package:women_fitness_flutter/module/home/home_states.dart';
import 'package:women_fitness_flutter/module/in_app_purchase/IAPPage.dart';
import 'package:women_fitness_flutter/module/report/report_page.dart';
import 'package:women_fitness_flutter/module/setting/setting_page.dart';
import 'package:women_fitness_flutter/module/training/training_page.dart';
import 'package:women_fitness_flutter/module/workout/workout_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  HomeBloc _homeBloc;

  PersistentTabController _controller;
  List<Section> listSections;
  List<WorkOut> listWorkOuts;

  InAppPurchaseConnection _appPurchaseConnection =
      InAppPurchaseConnection.instance;

  bool isLoadedAds = false;

  @override
  void initState() {
    super.initState();

    _homeBloc = Injector.resolve<HomeBloc>();
    _controller = PersistentTabController(initialIndex: 0);

    _initAdMob();

    var admobBox = Hive.box('admob_fitness');
    admobBox.watch().listen((event) {
      AdmobFitness admobFitness = event.value;
      setState(() {
        isLoadedAds = admobFitness.isLoaded;
      });
    });

    _getPastPurchases();
  }

  Future<void> _getPastPurchases() async {
    if (await _appPurchaseConnection.isAvailable()) {
      QueryPurchaseDetailsResponse response =
          await _appPurchaseConnection.queryPastPurchases();

      var iapBox = Hive.box('iap_fitness');
      if (response.pastPurchases.length == 0) {
        _loadAds();

        IAPFitness iapFitness = IAPFitness(isBuy: false, idIAP: 'premium');
        iapBox.put('premium', iapFitness);
      } else {
        IAPFitness iapFitness = IAPFitness(isBuy: true, idIAP: 'premium');
        iapBox.put('premium', iapFitness);
      }

      print('length past purchase= ${response.pastPurchases.length}');
    }else{
      _loadAds();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = ModalRoute.of(context).settings.arguments as Map;
    if (args != null) {
      listSections = args['list_section'];
      listWorkOuts = args['list_workout'];
    }
  }

  Future<void> _loadAds() async {
    await AdTask.instance.getAdsServerConfig();
    await AdTask.instance.loadBannerAdsGoogle();
    // await loadRewardGoogle(this);
  }

  _initAdMob() {
    FacebookAudienceNetwork.init(
        testingId: "55245acc-562e-461f-88fd-21a33ef4a290");
    FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: TextApp(
          content: 'Women\'s Fitness',
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/svg/crown.svg',
              width: 25,
              height: 25,
              color: Colors.white,
            ),
            onPressed: () {
              pushNewScreen(
                context,
                screen: IAPPage(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: BlocProvider<HomeBloc>(
          create: (_) => _homeBloc,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) => Container(
              margin: isLoadedAds
                  ? EdgeInsets.only(bottom: 50)
                  : EdgeInsets.only(bottom: 0),
              child: PersistentTabView(
                controller: _controller,
                items: _navBarsItems(),
                screens: _buildScreens(),
                confineInSafeArea: false,
                backgroundColor: Colors.white,
                handleAndroidBackButtonPress: true,
                resizeToAvoidBottomInset: true,
                // This needs to be true if you want to move up the screen when keyboard appears.
                hideNavigationBarWhenKeyboardShows: true,
                stateManagement: true,
                popAllScreensOnTapOfSelectedTab: true,
                itemAnimationProperties: ItemAnimationProperties(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimation(
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle.style3,
              ),
            ),
            listener: (context, state) {
              if (state is HomeStateShowTabWorkOut) {
                _controller.index = 1;
              }
            },
          ),
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: (S.current.nav_training),
        activeColor: AppColor.main,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.assistant_photo),
        title: (S.current.nav_workouts),
        activeColor: AppColor.main,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.show_chart),
        title: (S.current.nav_report),
        activeColor: AppColor.main,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: (S.current.nav_settings),
        activeColor: AppColor.main,
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      TrainingPage(
        listSections: listSections,
        listWorkOuts: listWorkOuts,
      ),
      WorkoutPage(
        listSections: listSections,
        listWorkOuts: listWorkOuts,
      ),
      ReportPage(
        listSections: listSections,
      ),
      SettingPage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();

    AdTask.instance.destroyBannerAds();
    _controller.dispose();
    _homeBloc.close();
  }
}
