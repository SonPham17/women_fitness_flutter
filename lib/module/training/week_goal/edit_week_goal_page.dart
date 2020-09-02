import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/ad/ad_task.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_picker.dart';
import 'package:women_fitness_flutter/shared/widget/page_container.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class EditWeekGoalPage extends StatefulWidget {
  final int weeklyTraining;

  EditWeekGoalPage({@required this.weeklyTraining});

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

  int chooseWeeklyTraining;

  String firstDay = 'Monday';

  @override
  void initState() {
    super.initState();
    chooseWeeklyTraining = widget.weeklyTraining;
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SafeArea(
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
                  content: S.current.edit_wg_set.toUpperCase(),
                  textColor: Colors.black,
                  size: SizeConfig.defaultSize * 3,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize,
              ),
              TextApp(
                content: S.current.edit_recommend,
                textColor: Colors.black,
                size: SizeConfig.defaultSize * 1.7,
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.defaultSize * 6,
                ),
                child: TextApp(
                  content: S.current.edit_training_day,
                  textColor: Colors.black,
                  size: SizeConfig.defaultSize * 2,
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => DialogPicker(
                      title: S.current.edit_training_day,
                      items: itemsWeekly,
                      initValue: chooseWeeklyTraining.toString(),
                    ),
                    barrierDismissible: true,
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        chooseWeeklyTraining = int.parse(value);
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
                        content: chooseWeeklyTraining == 1
                            ? '$chooseWeeklyTraining ${S.current.edit_day}'
                            : '$chooseWeeklyTraining ${S.current.edit_days}',
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
                    onPressed: () {
                      Navigator.of(context).pop(chooseWeeklyTraining);
                    },
                    child: Center(
                      child: TextApp(
                        content: S.current.edit_save.toUpperCase(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
