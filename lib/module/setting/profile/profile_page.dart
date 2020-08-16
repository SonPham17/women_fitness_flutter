import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_edit.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

enum TypeUnits { kgCm, lbFt }

class _ProfilePageState extends State<ProfilePage> {
  TypeUnits _type = TypeUnits.kgCm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextApp(
          content: 'profile'.toUpperCase(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              content: 'Units',
              size: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: TextApp(
                      content: 'kg, cm',
                    ),
                    leading: Radio(
                      value: TypeUnits.kgCm,
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: TextApp(
                      content: 'lb, ft',
                    ),
                    leading: Radio(
                      value: TypeUnits.lbFt,
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            TextApp(
              content: 'Weight',
              size: 20,
            ),
            InkWell(
              onTap: () {
//                showDialog(
//                  context: context,
//                  builder: (_) => DialogPicker(
//                    title: 'Weekly training days',
//                    items: itemsWeekly,
//                    initValue: weeklyTraining,
//                  ),
//                  barrierDismissible: true,
//                ).then((value) {
//                  if (value != null) {
//                    setState(() {
//                      weeklyTraining = value;
//                    });
//                  }
//                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                    ),
                  ),
                ),
                child: TextApp(
                  content: '50 KG',
                  size: SizeConfig.defaultSize * 2,
                  textColor: AppColor.main,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextApp(
              content: 'Height',
              size: 20,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogEdit(
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                    ),
                  ),
                ),
                child: TextApp(
                  content: '170 CM',
                  size: SizeConfig.defaultSize * 2,
                  textColor: AppColor.main,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextApp(
              content: 'Year of Birth',
              size: 20,
            ),
            InkWell(
              onTap: () {
//                showDialog(
//                  context: context,
//                  builder: (_) => DialogPicker(
//                    title: 'Weekly training days',
//                    items: itemsWeekly,
//                    initValue: weeklyTraining,
//                  ),
//                  barrierDismissible: true,
//                ).then((value) {
//                  if (value != null) {
//                    setState(() {
//                      weeklyTraining = value;
//                    });
//                  }
//                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                    ),
                  ),
                ),
                child: TextApp(
                  content: '1990-01-01',
                  size: SizeConfig.defaultSize * 2,
                  textColor: AppColor.main,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
