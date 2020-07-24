import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_picker.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class EditWeekGoalPage extends StatefulWidget {
  @override
  _EditWeekGoalPageState createState() => _EditWeekGoalPageState();
}

class _EditWeekGoalPageState extends State<EditWeekGoalPage> {
  final itemsWeekly = List<String>.generate(7, (i) => (i + 1).toString());
  final itemsFirstDay = [
    'Sunday',
    'Monday',
    'Saturday',
  ];

  String weeklyTraining = '3';
  String firstDay = 'Monday';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: SizeConfig.defaultSize * 3,
            right: SizeConfig.defaultSize * 3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: TextApp(
                  content: 'SET YOUR WEEKLY GOAL',
                  textColor: Colors.black,
                  size: SizeConfig.defaultSize * 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize,
              ),
              TextApp(
                content:
                    'We recommend training at least 3 days weekly for a better result.',
                textColor: Colors.black,
                size: SizeConfig.defaultSize * 1.7,
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.defaultSize * 6,
                ),
                child: TextApp(
                  content: 'Weekly training days',
                  textColor: Colors.black,
                  size: SizeConfig.defaultSize * 2,
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => DialogPicker(
                      title: 'Weekly training days',
                      items: itemsWeekly,
                      initValue: weeklyTraining,
                    ),
                    barrierDismissible: true,
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        weeklyTraining = value;
                      });
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.defaultSize,
                  ),
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.defaultSize,
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black26,
                    width: 1,
                  ))),
                  child: Row(
                    children: <Widget>[
                      TextApp(
                        content: int.parse(weeklyTraining) == 1
                            ? '$weeklyTraining day'
                            : '$weeklyTraining days',
                        size: SizeConfig.defaultSize * 2,
                        textColor: AppColor.main,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AppColor.main,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.defaultSize * 4,
                ),
                child: TextApp(
                  content: 'First day of week',
                  textColor: Colors.black,
                  size: SizeConfig.defaultSize * 2,
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => DialogPicker(
                      title: 'First day of week',
                      items: itemsFirstDay,
                      initValue: firstDay,
                    ),
                    barrierDismissible: true,
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        firstDay = value;
                      });
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.defaultSize,
                  ),
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.defaultSize,
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black26,
                    width: 1,
                  ))),
                  child: Row(
                    children: <Widget>[
                      TextApp(
                        content: firstDay,
                        size: SizeConfig.defaultSize * 2,
                        textColor: AppColor.main,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AppColor.main,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: SizeConfig.defaultSize * 9),
                  width: SizeConfig.defaultSize * 20,
                  height: SizeConfig.defaultSize * 5,
                  child: FlatButton(
                    padding: EdgeInsets.all(10),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: AppColor.main,
                    onPressed: () {},
                    child: Center(
                      child: TextApp(
                        content: 'SAVE',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
