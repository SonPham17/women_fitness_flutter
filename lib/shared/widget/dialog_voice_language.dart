import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class DialogVoiceLanguage extends StatefulWidget {
  @override
  _DialogVoiceLanguageState createState() => _DialogVoiceLanguageState();
}

class _DialogVoiceLanguageState extends State<DialogVoiceLanguage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Container(
        height: 250,
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
            RadioButtonGroup(
              labels: <String>[
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
