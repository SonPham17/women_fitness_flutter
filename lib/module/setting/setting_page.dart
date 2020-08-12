import 'package:flutter/material.dart';
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemSettingWidget(
              title: 'Thông tin của tôi',
              iconData: Icons.edit,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
              child: TextApp(
                content: 'Chương trình'.toUpperCase(),
                textColor: AppColor.main,
              ),
            ),
            Divider(),
            ItemSettingWidget(
              title: 'Đặt thời gian nghỉ',
              iconData: Icons.local_cafe,
            ),
            ItemSettingWidget(
              title: 'Thời gian đếm ngược',
              iconData: Icons.timer,
            ),
            ItemSettingWidget(
              title: 'Âm thanh',
              iconData: Icons.volume_up,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
              child: TextApp(
                content: 'Lựa chọn voice (tts)'.toUpperCase(),
                textColor: AppColor.main,
              ),
            ),
            Divider(),
            ItemSettingWidget(
              title: 'Âm thanh',
              iconData: Icons.volume_up,
            ),
            ItemSettingWidget(
              title: 'Chọn Công cụ TTS',
              iconData: Icons.volume_up,
            ),
            ItemSettingWidget(
              title: 'Tải xuống TTS Engine',
              iconData: Icons.volume_up,
            ),
            ItemSettingWidget(
              title: 'Ngôn ngữ nói',
              iconData: Icons.volume_up,
            ),
            ItemSettingWidget(
              title: 'Tải xuống thêm dữ liệu ngôn ngữ TTS',
              iconData: Icons.volume_up,
            ),
            ItemSettingWidget(
              title: 'Cài đặt TTS thiết bị',
              iconData: Icons.volume_up,
            ),
          ],
        ),
      ),
    );
  }
}
