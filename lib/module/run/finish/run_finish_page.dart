import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/report/report_events.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_bloc.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_events.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_edit.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class RunFinishPage extends StatefulWidget {
  @override
  _RunFinishPageState createState() => _RunFinishPageState();
}

class _RunFinishPageState extends State<RunFinishPage> {
  RunFinishBloc _runFinishBloc;

  double calculatorBMI;
  double currentHeight;
  double weight;
  String statusWeight;

  double calBMI() {
    if (calculatorBMI < 13.5) {
      calculatorBMI = 13.5;
    } else if (calculatorBMI > 40.5) {
      calculatorBMI = 40.5;
    }
    double f = (calculatorBMI - 13.5) / 27.0;
    var a = ((SizeConfig.screenWidth - 48) * f).toInt() - 2;
    if (a <= 0) {
      a = 0;
    }
    return a.toDouble();
  }

  @override
  void initState() {
    super.initState();

    _runFinishBloc = Injector.resolve<RunFinishBloc>();

    SPref.instance
        .getDouble(Utils.sPrefHeight)
        .then((value) => currentHeight = value);

    SPref.instance.getDouble(Utils.sPrefWeight).then((value) => weight = value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RunFinishBloc>(
      create: (_) => _runFinishBloc,
      child: BlocConsumer<RunFinishBloc, RunFinishState>(
        listener: (_, state) {},
        builder: (_, state) => Scaffold(
          body: Container(
            child: Stack(
              children: [
                NestedScrollView(
                  body: CustomScrollView(
                    slivers: <Widget>[
                      _buildBMI(),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black12,
                        ),
                      ),
                      _buildHeight(),
                    ],
                  ),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 350,
                        forceElevated: innerBoxIsScrolled,
                        floating: false,
                        pinned: true,
                        flexibleSpace: _buildFlexible(),
                        centerTitle: false,
                        leading: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).popUntil(
                                (route) => route.settings.name == '/home');
                          },
                        ),
                      )
                    ];
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeight() => SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(left: 14, right: 14, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextApp(
                    content: 'Height',
                    textColor: Colors.black,
                    size: 17,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextApp(
                        content: 'EDIT',
                        textColor: AppColor.main,
                        size: 17,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DialogEdit(
                          isStartReportPage: false,
                        ),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            weight = double.parse(value[0]);
                            currentHeight = double.parse(value[1]);
                            _runFinishBloc.add(RunFinishRefreshEvent(
                              weight: weight,
                              height: currentHeight,
                            ));
                          });
                        }
                      });
                    },
                  ),
                ],
              ),
              FutureBuilder<bool>(
                future: SPref.instance.getBool(Utils.sPrefIsKgCm),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    bool isKg = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextApp(
                          content: 'Current',
                          textColor: AppColor.main,
                          size: 17,
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextApp(
                              content: isKg
                                  ? '$currentHeight CM'
                                  : '$currentHeight FT',
                              textColor: Colors.black26,
                              size: 17,
                            ),
                          ),
                          onTap: () {
                            print('edit');
                          },
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildBMI() => SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(left: 14, right: 14, top: 10),
          child: FutureBuilder<bool>(
            future: SPref.instance.getBool(Utils.sPrefIsKgCm),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                bool isKg = snapshot.data;
                if (isKg) {
                  calculatorBMI = double.parse(
                      Utils.calculatorBMI(currentHeight, weight)
                          .toStringAsFixed(1));
                } else {
                  calculatorBMI = double.parse(Utils.calculatorBMI(
                          Utils.convertFtToCm(currentHeight),
                          Utils.convertLbsToKg(weight))
                      .toStringAsFixed(1));
                }

                if (calculatorBMI < 18.5) {
                  statusWeight = 'Underweight';
                } else if (calculatorBMI >= 18.5 && calculatorBMI < 25.0) {
                  statusWeight = 'Normal weight';
                } else if (calculatorBMI < 25.0 || calculatorBMI >= 30.0) {
                  statusWeight = 'Obesity';
                } else {
                  statusWeight = 'Overweight';
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        TextApp(
                          content: 'BMI(kg/m2):',
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextApp(
                            content: '$calculatorBMI',
                            textColor: Colors.black,
                            fontWeight: FontWeight.bold,
                            size: 20,
                          ),
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextApp(
                              content: 'EDIT',
                              textColor: AppColor.main,
                              size: 17,
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogEdit(
                                isStartReportPage: false,
                              ),
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  weight = double.parse(value[0]);
                                  currentHeight = double.parse(value[1]);
                                });
                              }
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Image.asset(
                              'assets/images/bmi.png',
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            bottom: 20,
                            left: 0,
                            right: 0,
                            top: 35,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: calBMI()),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextApp(
                                  maxLines: 1,
                                  content: '$calculatorBMI',
                                  textColor: Colors.black,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 14),
                                    width: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextApp(
                            content: '15',
                          ),
                          TextApp(
                            content: '18',
                          ),
                          TextApp(
                            content: '21',
                          ),
                          TextApp(
                            content: '24',
                          ),
                          TextApp(
                            content: '27',
                          ),
                          TextApp(
                            content: '30',
                          ),
                          TextApp(
                            content: '33',
                          ),
                          TextApp(
                            content: '36',
                          ),
                          TextApp(
                            content: '39',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextApp(
                      content: statusWeight,
                      textColor: AppColor.main,
                      size: 13,
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),
      );

  Widget _buildFlexible() => FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash_ft.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextApp(
                content: 'you rock!'.toUpperCase(),
                size: 45,
                fontWeight: FontWeight.bold,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: Colors.white,
                      ),
                      TextApp(
                        content: '20',
                        size: 26,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                      TextApp(
                        content: 'Exercises',
                        textColor: Colors.white,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: Colors.white,
                      ),
                      TextApp(
                        content: '26',
                        size: 26,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                      TextApp(
                        content: 'Calories',
                        textColor: Colors.white,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: Colors.white,
                      ),
                      TextApp(
                        content: '00:05',
                        size: 26,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                      TextApp(
                        content: 'Minutes',
                        textColor: Colors.white,
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 20, top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onPressed: () {
//                      Navigator.of(context).pop(widget.workOut);
                        },
                        padding: EdgeInsets.all(10),
                        color: Colors.grey,
                        textColor: Colors.white,
                        child: TextApp(
                          content: 'DO IT AGAIN',
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onPressed: () {
//                      Navigator.of(context).pop(widget.workOut);
                        },
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        textColor: Colors.black,
                        child: TextApp(
                          content: 'SHARE',
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _runFinishBloc.close();
  }
}