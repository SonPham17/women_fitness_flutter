import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_bloc.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_events.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

enum TypeUnits { kgCm, lbFt }

class _ProfilePageState extends State<ProfilePage> {
  double weight;
  double height;
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();

    _profileBloc = Injector.resolve<ProfileBloc>();

    SPref.instance.getDouble(Utils.sPrefHeight).then((value) {
      setState(() {
        height = value;
      });
    });

    SPref.instance.getDouble(Utils.sPrefWeight).then((value) {
      setState(() {
        weight = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _profileBloc,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        builder: (_, state) {
          return Scaffold(
            appBar: AppBar(
              title: TextApp(
                content: 'profile'.toUpperCase(),
              ),
            ),
            body: FutureBuilder<bool>(
              future: SPref.instance.getBool(Utils.sPrefIsKgCm),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  bool isKg = snapshot.data;
                  return Container(
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
                                  groupValue:
                                      isKg ? TypeUnits.kgCm : TypeUnits.lbFt,
                                  onChanged: (value) {
                                    setState(() {
                                      SPref.instance
                                          .setBool(Utils.sPrefIsKgCm, true);
                                      weight = double.parse(
                                          Utils.convertLbsToKg(weight)
                                              .toStringAsFixed(0));
                                      height = double.parse(
                                          Utils.convertFtToCm(height)
                                              .toStringAsFixed(0));
                                      SPref.instance
                                          .setDouble(Utils.sPrefWeight, weight);
                                      SPref.instance
                                          .setDouble(Utils.sPrefHeight, height);
                                      _profileBloc.add(ProfileRefreshEvent(
                                        height: height,
                                        weight: weight,
                                        isKg: true,
                                      ));
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
                                  groupValue:
                                      isKg ? TypeUnits.kgCm : TypeUnits.lbFt,
                                  onChanged: (value) {
                                    setState(() {
                                      SPref.instance
                                          .setBool(Utils.sPrefIsKgCm, false);
                                      weight = double.parse(
                                          Utils.convertKgToLbs(weight)
                                              .toStringAsFixed(0));
                                      height = double.parse(
                                          Utils.convertCmToFt(height)
                                              .toStringAsFixed(0));
                                      SPref.instance
                                          .setDouble(Utils.sPrefWeight, weight);
                                      SPref.instance
                                          .setDouble(Utils.sPrefHeight, height);
                                      _profileBloc.add(ProfileRefreshEvent(
                                        height: height,
                                        weight: weight,
                                        isKg: false,
                                      ));
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
                            _profileBloc.add(ProfileRefreshEvent());
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
                              content: '$weight ${isKg ? 'KG' : 'LB'}',
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
//                showDialog(
//                  context: context,
//                  builder: (context) => DialogEdit(
//                  ),
//                );
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
                              content: '$height ${isKg ? 'CM' : 'FT'}',
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
                  );
                }
                return Container();
              },
            ),
          );
        },
        listener: (_, state) {},
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.close();
  }
}
