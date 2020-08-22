import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class FirstInstallNextPage extends StatefulWidget {
  @override
  _FirstInstallNextPageState createState() => _FirstInstallNextPageState();
}

class _FirstInstallNextPageState extends State<FirstInstallNextPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isChooseKg = true;

  final textWeightController = TextEditingController();
  final textHeightController = TextEditingController();

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
    return Scaffold(
      key: _scaffoldKey,
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
              content: S.current.first_weight_height,
              textColor: Colors.white,
              size: 25,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextApp(
                    content: S.current.setting_weight,
                    size: 25,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textWeightController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Material(
                        child: Ink(
                          decoration: BoxDecoration(
                            color: isChooseKg ? AppColor.main : Colors.white,
                            border: Border.all(
                                width: 1,
                                color:
                                    isChooseKg ? AppColor.main : Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (!isChooseKg) {
                                setState(() {
                                  var weight = textWeightController.text;
                                  var height = textHeightController.text;
                                  if (weight.isNotEmpty) {
                                    textWeightController.text =
                                        Utils.convertLbsToKg(
                                                double.parse(weight))
                                            .toStringAsFixed(0);
                                  }
                                  if (height.isNotEmpty) {
                                    textHeightController.text =
                                        Utils.convertFtToCm(
                                                double.parse(height))
                                            .toStringAsFixed(0);
                                  }
                                  isChooseKg = true;
                                  SPref.instance
                                      .setBool(Utils.sPrefIsKgCm, isChooseKg);
                                });
                              }
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              child: Center(
                                child: TextApp(
                                  content: 'KG',
                                  textColor:
                                      isChooseKg ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Ink(
                          decoration: BoxDecoration(
                            color: isChooseKg ? Colors.white : AppColor.main,
                            border: Border.all(
                              width: 1,
                              color: isChooseKg ? Colors.black : AppColor.main,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (isChooseKg) {
                                setState(() {
                                  var weight = textWeightController.text;
                                  var height = textHeightController.text;
                                  if (weight.isNotEmpty) {
                                    textWeightController.text =
                                        Utils.convertKgToLbs(
                                                double.parse(weight))
                                            .toStringAsFixed(1);
                                  }
                                  if (height.isNotEmpty) {
                                    textHeightController.text =
                                        Utils.convertCmToFt(
                                                double.parse(height))
                                            .toStringAsFixed(1);
                                  }
                                  isChooseKg = false;
                                  SPref.instance
                                      .setBool(Utils.sPrefIsKgCm, isChooseKg);
                                });
                              }
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              child: Center(
                                child: TextApp(
                                  content: 'LB',
                                  textColor:
                                      isChooseKg ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextApp(
                    content: S.current.report_height,
                    size: 25,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textHeightController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Material(
                        child: Ink(
                          decoration: BoxDecoration(
                            color: isChooseKg ? AppColor.main : Colors.white,
                            border: Border.all(
                                width: 1,
                                color:
                                    isChooseKg ? AppColor.main : Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (!isChooseKg) {
                                setState(() {
                                  var weight = textWeightController.text;
                                  var height = textHeightController.text;
                                  if (weight.isNotEmpty) {
                                    textWeightController.text =
                                        Utils.convertLbsToKg(
                                                double.parse(weight))
                                            .toStringAsFixed(0);
                                  }
                                  if (height.isNotEmpty) {
                                    textHeightController.text =
                                        Utils.convertFtToCm(
                                                double.parse(height))
                                            .toStringAsFixed(0);
                                  }
                                  isChooseKg = true;
                                  SPref.instance
                                      .setBool(Utils.sPrefIsKgCm, isChooseKg);
                                });
                              }
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              child: Center(
                                child: TextApp(
                                  content: 'CM',
                                  textColor:
                                      isChooseKg ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Ink(
                          decoration: BoxDecoration(
                            color: isChooseKg ? Colors.white : AppColor.main,
                            border: Border.all(
                              width: 1,
                              color: isChooseKg ? Colors.black : AppColor.main,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (isChooseKg) {
                                setState(() {
                                  var weight = textWeightController.text;
                                  var height = textHeightController.text;
                                  if (weight.isNotEmpty) {
                                    textWeightController.text =
                                        Utils.convertKgToLbs(
                                                double.parse(weight))
                                            .toStringAsFixed(1);
                                  }
                                  if (height.isNotEmpty) {
                                    textHeightController.text =
                                        Utils.convertCmToFt(
                                                double.parse(height))
                                            .toStringAsFixed(1);
                                  }
                                  isChooseKg = false;
                                  SPref.instance
                                      .setBool(Utils.sPrefIsKgCm, isChooseKg);
                                });
                              }
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              child: Center(
                                child: TextApp(
                                  content: 'FT',
                                  textColor:
                                      isChooseKg ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
                    var weight = textWeightController.text;
                    var height = textHeightController.text;
                    if (weight.isNotEmpty && height.isNotEmpty) {
                      SPref.instance
                          .setDouble(Utils.sPrefWeight, double.parse(weight));
                      SPref.instance
                          .setDouble(Utils.sPrefHeight, double.parse(height));
                      SPref.instance.setBool(Utils.sPrefIsKgCm, isChooseKg);
                      Navigator.pushReplacementNamed(context, '/home',
                          arguments: {
                            'list_workout': listWorkOuts,
                            'list_section': listSections,
                          });
                    } else {
                      _displaySnackBar(context);
                    }
                  },
                  child: Center(
                    child: TextApp(
                      size: 20,
                      content: S.current.first_finish.toUpperCase(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: TextApp(
        content: S.current.report_empty,
      ),
      backgroundColor: AppColor.main,
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    textHeightController.dispose();
    textWeightController.dispose();
  }
}
