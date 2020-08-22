import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class DialogSoundOption extends StatefulWidget {
  @override
  _DialogSoundOptionState createState() => _DialogSoundOptionState();
}

class _DialogSoundOptionState extends State<DialogSoundOption> {
  bool mute = false;
  bool voiceGuide = true;
  bool coachTips = true;

  @override
  void initState() {
    super.initState();

    SPref.instance.getBool(Utils.sPrefSoundMute).then((value) {
      setState(() {
        mute = value ?? false;
      });
    });
    SPref.instance.getBool(Utils.sPrefSoundVoiceGuide).then((value) {
      setState(() {
        voiceGuide = value ?? true;
      });
    });
    SPref.instance.getBool(Utils.sPrefSoundCoachTips).then((value) {
      setState(() {
        coachTips = value ?? true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Container(
        height: 270,
        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextApp(
              textColor: Colors.black,
              fontWeight: FontWeight.bold,
              size: 20,
              content: S.current.dialog_sound_op,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.volume_up),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextApp(
                    content: S.current.dialog_sound_mute,
                  ),
                ),
                Switch(
                  value: mute,
                  activeColor: AppColor.main,
                  onChanged: (newValue) {
                    setState(() {
                      mute = newValue;
                      if (mute) {
                        voiceGuide = false;
                        coachTips = false;
                      }
                    });
                  },
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.volume_up),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextApp(
                    content: S.current.dialog_sound_voice_guide,
                  ),
                ),
                Switch(
                  value: voiceGuide,
                  activeColor: AppColor.main,
                  onChanged: (newValue) {
                    if (!mute) {
                      setState(() {
                        voiceGuide = newValue;
                      });
                    }
                  },
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.volume_up),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextApp(
                    content: S.current.dialog_sound_coach_tips,
                  ),
                ),
                Switch(
                  value: coachTips,
                  activeColor: AppColor.main,
                  onChanged: (newValue) {
                    if (!mute) {
                      setState(() {
                        coachTips = newValue;
                      });
                    }
                  },
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  child: TextApp(
                    content: S.current.dialog_picker_ok.toUpperCase(),
                    textColor: AppColor.main,
                  ),
                  onPressed: () {
                    SPref.instance.setBool(Utils.sPrefSoundMute, mute);
                    SPref.instance
                        .setBool(Utils.sPrefSoundCoachTips, coachTips);
                    SPref.instance
                        .setBool(Utils.sPrefSoundVoiceGuide, voiceGuide);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
