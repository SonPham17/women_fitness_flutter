import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:women_fitness_flutter/ad/ad_manager.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_setting_time.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_sound_option.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_voice_language.dart';
import 'package:women_fitness_flutter/shared/widget/item_setting_widget.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with WidgetsBindingObserver{
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
//    appStoreIdentifier: '',
//    googlePlayIdentifier: '',
  );

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  FlutterTts flutterTts;
  dynamic languages;
  int indexVoiceLanguage = 1;
  double rate = 0.5;
  String voiceLanguageSelection = '';

  int timeSet = 30;
  int countDownTime = 15;

  BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _bannerAd = createBannerAd()
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );

    SPref.instance.getInt(Utils.sPrefIndexVoiceLanguage).then((value) {
      setState(() {
        indexVoiceLanguage = value ?? 1;
        voiceLanguageSelection = Utils.listLanguage[indexVoiceLanguage];
      });
      initTts();
    });

    SPref.instance.getInt(Utils.sPrefTimeSet).then((value) {
      setState(() {
        timeSet = value ?? 30;
      });
    });

    SPref.instance.getInt(Utils.sPrefCountdownTime).then((value) {
      setState(() {
        countDownTime = value ?? 15;
      });
    });
  }

  Future<void> initTts() async {
    flutterTts = FlutterTts();

    flutterTts.setLanguage(Utils.listCodeLanguage[indexVoiceLanguage]);

    languages = await flutterTts.getLanguages;

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        rate = 0.9;
        var engines = await flutterTts.getEngines;
        if (engines != null) {
          for (dynamic engine in engines) {
            print(engine);
          }
        }
      }
    }

    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemSettingWidget(
              function: () {
                pushNewScreen(
                  context,
                  screen: ProfilePage(),
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  withNavBar: false,
                );
              },
              title: S.current.setting_profile,
              iconData: Icons.edit,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 20),
              color: Colors.grey[200],
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextApp(
                  content: S.current.setting_workout.toUpperCase(),
                  textColor: AppColor.main,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[400],
            ),
            ItemSettingWidget(
              function: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogSettingTime(
                    isRestSet: true,
                    time: timeSet,
                  ),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      SPref.instance.setInt(Utils.sPrefTimeSet, value);
                      timeSet = value;
                    });
                  }
                });
              },
              isShowTime: true,
              title: S.current.setting_rest_set,
              selection: '$timeSet ${S.current.dialog_second}',
              iconData: Icons.local_cafe,
            ),
            ItemSettingWidget(
              isShowTime: true,
              selection: '$countDownTime ${S.current.dialog_second}',
              title: S.current.setting_countdown_time,
              iconData: Icons.timer,
              function: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogSettingTime(
                    isRestSet: false,
                    time: countDownTime,
                  ),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      SPref.instance.setInt(Utils.sPrefCountdownTime, value);
                      countDownTime = value;
                    });
                  }
                });
              },
            ),
            ItemSettingWidget(
              title: S.current.setting_sound,
              iconData: Icons.volume_up,
              function: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogSoundOption(),
                );
              },
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 20),
              color: Colors.grey[200],
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextApp(
                  content: S.current.setting_voice_option.toUpperCase(),
                  textColor: AppColor.main,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[400],
            ),
            ItemSettingWidget(
              title: S.current.setting_test_voice,
              iconData: Icons.record_voice_over,
              function: () {
                flutterTts.speak(S.current.setting_test_speak);
              },
            ),
            ItemSettingWidget(
              selection: voiceLanguageSelection,
              title: S.current.setting_voice_language,
              function: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogVoiceLanguage(
                    indexVoice: indexVoiceLanguage,
                  ),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      indexVoiceLanguage = value;
                      flutterTts.setLanguage(
                          Utils.listCodeLanguage[indexVoiceLanguage]);
                      voiceLanguageSelection = Utils.listLanguage[value];
                    });
                  }
                });
              },
              isShowTime: true,
              iconData: Icons.keyboard_voice,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 20),
              color: Colors.grey[200],
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextApp(
                  content: S.current.setting_general.toUpperCase(),
                  textColor: AppColor.main,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[400],
            ),
//            ItemSettingWidget(
//              isShowTime: true,
//              selection: 'English',
//              title: S.current.setting_language,
//              iconData: Icons.translate,
//            ),
            ItemSettingWidget(
              title: S.current.setting_restart_progress,
              iconData: Icons.refresh,
            ),
            ItemSettingWidget(
              title: S.current.setting_share,
              iconData: Icons.share,
              function: share,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 20),
              color: Colors.grey[200],
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextApp(
                  content: S.current.setting_support.toUpperCase(),
                  textColor: AppColor.main,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[400],
            ),
            ItemSettingWidget(
              title: S.current.setting_rate,
              iconData: Icons.star,
              function: clickRate,
            ),
            ItemSettingWidget(
              title: S.current.setting_feedback,
              iconData: Icons.feedback,
              function: feedback,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  void clickRate() {
    _rateMyApp.init().then((value) {
      _rateMyApp.showStarRateDialog(
        context,
        title: 'Women Fitness App',
        message: 'Please leave a rating!',
        actionsBuilder: (context, starts) {
          return [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                if (starts != null) {
                  _rateMyApp
                      .callEvent(RateMyAppEventType.rateButtonPressed)
                      .then((_) => Navigator.pop<RateMyAppDialogButton>(
                          context, RateMyAppDialogButton.rate));
                }
              },
            )
          ];
        },
        dialogStyle: DialogStyle(
          titleAlign: TextAlign.center,
          messageAlign: TextAlign.center,
          messagePadding: EdgeInsets.only(bottom: 20.0),
        ),
        starRatingOptions: StarRatingOptions(),
      );
    });
  }

  Future<void> feedback() async {
    await FlutterShare.share(
        title: 'Phản hồi',
        text: 'Liên hệ phản hồi: ',
        linkUrl: 'womenfitness@gmail.com',
        chooserTitle: 'Feedback Chooser Title');
  }

  @override
  void deactivate() {
    super.deactivate();
    _bannerAd.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    flutterTts.stop();
    WidgetsBinding.instance.removeObserver(this);
  }
}
