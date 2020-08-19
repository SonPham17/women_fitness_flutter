import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/module/report/report_bloc.dart';
import 'package:women_fitness_flutter/module/report/report_events.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class DialogEdit extends StatefulWidget {
  final ReportBloc reportBloc;
  final bool isStartReportPage;

  DialogEdit({this.reportBloc, @required this.isStartReportPage});

  @override
  _DialogEditState createState() => _DialogEditState();
}

class _DialogEditState extends State<DialogEdit> {
  bool isChooseKg;
  final textWeightController = TextEditingController();
  final textHeightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SPref.instance
        .getDouble(Utils.sPrefHeight)
        .then((value) => textHeightController.text = value.toString() ?? '');
    SPref.instance
        .getDouble(Utils.sPrefWeight)
        .then((value) => textWeightController.text = value.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SPref.instance.getBool(Utils.sPrefIsKgCm),
      builder: (context1, snapshot) {
        isChooseKg = snapshot.data ?? true;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          child: Container(
            height: 300,
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextApp(
                  content: 'Weight',
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
                              color: isChooseKg ? AppColor.main : Colors.black),
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
                                      Utils.convertLbsToKg(double.parse(weight))
                                          .toStringAsFixed(0);
                                }
                                if (height.isNotEmpty) {
                                  textHeightController.text =
                                      Utils.convertFtToCm(double.parse(height))
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
                                      Utils.convertKgToLbs(double.parse(weight))
                                          .toStringAsFixed(1);
                                }
                                if (height.isNotEmpty) {
                                  textHeightController.text =
                                      Utils.convertCmToFt(double.parse(height))
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
                  content: 'Height',
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
                              color: isChooseKg ? AppColor.main : Colors.black),
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
                                      Utils.convertLbsToKg(double.parse(weight))
                                          .toStringAsFixed(0);
                                }
                                if (height.isNotEmpty) {
                                  textHeightController.text =
                                      Utils.convertFtToCm(double.parse(height))
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
                                      Utils.convertKgToLbs(double.parse(weight))
                                          .toStringAsFixed(1);
                                }
                                if (height.isNotEmpty) {
                                  textHeightController.text =
                                      Utils.convertCmToFt(double.parse(height))
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
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: TextApp(
                        content: 'CANCEL',
                        textColor: AppColor.main,
                        size: 18,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        var weight = textWeightController.text;
                        var height = textHeightController.text;
                        if (weight.isNotEmpty && height.isNotEmpty) {
                          SPref.instance.setDouble(
                              Utils.sPrefWeight, double.parse(weight));
                          SPref.instance.setDouble(
                              Utils.sPrefHeight, double.parse(height));
                          SPref.instance.setBool(Utils.sPrefIsKgCm, isChooseKg);
                          Navigator.of(context)
                              .pop([weight, height, isChooseKg]);
                        }else{
                          if (widget.isStartReportPage) {
                            widget.reportBloc.add(ReportSaveEmptyEvent());
                          }
                        }
                      },
                      child: TextApp(
                        content: 'SAVE',
                        textColor: AppColor.main,
                        size: 18,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    textHeightController.dispose();
    textWeightController.dispose();
  }
}
