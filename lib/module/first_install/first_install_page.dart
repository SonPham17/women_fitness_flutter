import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_picker.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class FirstInstallPage extends StatefulWidget {
  @override
  _FirstInstallPageState createState() => _FirstInstallPageState();
}

class _FirstInstallPageState extends State<FirstInstallPage> {
  int chooseWeeklyTraining = 3;
  final itemsWeekly = List<String>.generate(7, (i) => (i + 1).toString());

  List<Section> listSections;
  List<WorkOut> listWorkOuts;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = ModalRoute.of(context).settings.arguments as Map;
    if (args != null) {
      listSections = args['list_section'];
      listWorkOuts = args['list_workout'];
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFff80ab),
              Color(0xFFff8a80),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextApp(
              textAlign: TextAlign.center,
              content: S.current.first_target,
              textColor: Colors.white,
              size: 25,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextApp(
                    content: S.current.edit_recommend,
                    textColor: Colors.black,
                    size: SizeConfig.defaultSize * 1.7,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.defaultSize * 4,
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
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: SizeConfig.defaultSize * 20,
                height: SizeConfig.defaultSize * 5,
                child: FlatButton(
                  padding: EdgeInsets.all(10),
                  textColor: AppColor.main,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    SPref.instance
                        .setInt(Utils.sPrefWeekGoal, chooseWeeklyTraining);
                    Navigator.pushReplacementNamed(
                        context, '/first_install_next',arguments: {
                      'list_workout': listWorkOuts,
                      'list_section': listSections,
                    });
                  },
                  child: Center(
                    child: TextApp(
                      size: 20,
                      content: S.current.run_next.toUpperCase(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
