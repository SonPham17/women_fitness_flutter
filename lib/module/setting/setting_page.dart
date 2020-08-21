import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
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

class _SettingPageState extends State<SettingPage> {
  FlutterTts flutterTts;
  dynamic languages;
  int indexVoiceLanguage = 1;
  double rate = 0.5;
  String voiceLanguageSelection = '';

  int timeSet = 30;
  int countDownTime = 15;

  @override
  void initState() {
    super.initState();

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
              title: 'My profile',
              iconData: Icons.edit,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 20),
              color: Colors.grey[200],
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextApp(
                  content: 'workout'.toUpperCase(),
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
              title: 'Rest set',
              selection: '$timeSet secs',
              iconData: Icons.local_cafe,
            ),
            ItemSettingWidget(
              isShowTime: true,
              selection: '$countDownTime secs',
              title: 'Countdown Time',
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
              title: 'Sound',
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
                  content: 'voice options (tts)'.toUpperCase(),
                  textColor: AppColor.main,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[400],
            ),
            ItemSettingWidget(
              title: 'Test Voice',
              iconData: Icons.record_voice_over,
              function: () {
                flutterTts.speak('Did you hear the test voice?');
              },
            ),
            ItemSettingWidget(
              selection: voiceLanguageSelection,
              title: 'Voice language',
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
                  content: 'general'.toUpperCase(),
                  textColor: AppColor.main,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[400],
            ),
            ItemSettingWidget(
              isShowTime: true,
              selection: 'English',
              title: 'Language',
              iconData: Icons.translate,
            ),
            ItemSettingWidget(
              title: 'Restart Progress',
              iconData: Icons.refresh,
            ),
            ItemSettingWidget(
              title: 'Share with friends',
              iconData: Icons.share,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 20),
              color: Colors.grey[200],
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextApp(
                  content: 'support'.toUpperCase(),
                  textColor: AppColor.main,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[400],
            ),
            ItemSettingWidget(
              title: 'Rate us 5',
              iconData: Icons.star,
            ),
            ItemSettingWidget(
              title: 'Feedback',
              iconData: Icons.feedback,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
