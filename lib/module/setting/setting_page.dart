import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_page.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/widget/item_setting_widget.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
              function: (){
                pushNewScreen(
                  context,
                  screen: RunFinishPage(),
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  withNavBar: false,
                );
              },
              title: 'Rest set',
              iconData: Icons.local_cafe,
            ),
            ItemSettingWidget(
              title: 'Countdown Time',
              iconData: Icons.timer,
            ),
            ItemSettingWidget(
              title: 'Sound',
              iconData: Icons.volume_up,
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
            ),
            ItemSettingWidget(
              title: 'Select TTS Engine',
              iconData: Icons.send,
            ),
            ItemSettingWidget(
              title: 'Download TTS Engine',
              iconData: Icons.cloud_download,
            ),
            ItemSettingWidget(
              title: 'Voice language',
              iconData: Icons.keyboard_voice,
            ),
            ItemSettingWidget(
              title: 'Download more TTS language data',
              iconData: Icons.file_download,
            ),
            ItemSettingWidget(
              title: 'Device TTS Setting',
              iconData: Icons.tune,
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
}
