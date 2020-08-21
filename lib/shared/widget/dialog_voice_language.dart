import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class DialogVoiceLanguage extends StatefulWidget {
  final int indexVoice;

  DialogVoiceLanguage({@required this.indexVoice});

  @override
  _DialogVoiceLanguageState createState() => _DialogVoiceLanguageState();
}

class _DialogVoiceLanguageState extends State<DialogVoiceLanguage> {
  String _picked;
  int indexChoose;

  @override
  void initState() {
    super.initState();

    _picked = Utils.listLanguage[widget.indexVoice];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Container(
        height: 450,
        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              content: 'Voice language',
              fontWeight: FontWeight.bold,
              size: 20,
            ),
            Expanded(
              child: RadioButtonGroup(
                labels: <String>[
                  'Vietnamese',
                  'English',
                  'French',
                  'Korean',
                  'Spanish',
                  'Portuguese',
                  'Russian',
                ],
                picked: _picked,
                onSelected: (selected) {
                  setState(() {
                    _picked = selected;
                  });
                },
                onChange: (select, index) {
                  indexChoose = index;
                },
                activeColor: AppColor.main,
              ),
            ),
            Center(
              child: FlatButton(
                color: AppColor.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextApp(
                  content: 'OK',
                ),
                onPressed: () {
                  SPref.instance
                      .setInt(Utils.sPrefIndexVoiceLanguage, indexChoose);
                  Navigator.of(context).pop(indexChoose);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
