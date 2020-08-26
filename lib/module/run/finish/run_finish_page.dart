import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/db/hive/challenge_week.dart';
import 'package:women_fitness_flutter/db/hive/section_history.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_bloc.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_events.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_edit.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class RunFinishPage extends StatefulWidget {
  final Section section;
  final List<WorkOut> listWorkOutBySection;

  RunFinishPage({@required this.section, @required this.listWorkOutBySection});

  @override
  _RunFinishPageState createState() => _RunFinishPageState();
}

class _RunFinishPageState extends State<RunFinishPage> {
  RunFinishBloc _runFinishBloc;

  double calculatorBMI;
  double currentHeight;
  double weight;
  String statusWeight;

  int totalTime = 0;
  double calories = 0;

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

    _runFinishBloc = Injector.resolve<RunFinishBloc>()
      ..add(RunFinishGetAllSectionEvent(
        listWorkOuts: widget.listWorkOutBySection,
      ));

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
        listener: (_, state) {
          if (state is RunFinishStateGetAllSectionDone) {
            setState(() {
              totalTime = state.totalTime;
              calories = state.totalCalories;
            });

            var sectionBox = Hive.box('section_history');
            var data = state.listSections;
            int index =
                data.indexWhere((section) => section.id == widget.section.id);
            if (index > 17 && index < 45) {
              var challengeBox = Hive.box('challenge_week');
              var challengeWeek = ChallengeWeek(
                  idSection: data[index + 1].id,
                  title: data[index + 1].title,
                  index: challengeBox.length);
              challengeBox.put(data[index + 1].id, challengeWeek);
            }

            var sectionHistory = SectionHistory(
              sectionId: widget.section.id,
              totalTime: state.totalTime,
              calories: state.totalCalories,
              day: Utils.getDateNowFormat(),
              timeFinish: Utils.getDateNowFormatHour(),
              thumb: widget.section.thumb,
            );
            sectionBox.add(sectionHistory);
          }
        },
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
                    content: S.current.report_height,
                    textColor: Colors.black,
                    size: 17,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextApp(
                        content: S.current.report_edit.toUpperCase(),
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
                          content: S.current.report_current,
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
                  statusWeight = S.current.report_underweight;
                } else if (calculatorBMI >= 18.5 && calculatorBMI < 25.0) {
                  statusWeight = S.current.report_normal_weight;
                } else if (calculatorBMI < 25.0 || calculatorBMI >= 30.0) {
                  statusWeight = S.current.report_obesity;
                } else {
                  statusWeight = S.current.report_overweight;
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
                              content: S.current.report_edit.toUpperCase(),
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
                content: S.current.run_you_rock.toUpperCase(),
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
                        content: '${widget.listWorkOutBySection.length}',
                        size: 26,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                      TextApp(
                        content: S.current.report_chart_2,
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
                        content: calories.toStringAsFixed(2),
                        size: 26,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                      TextApp(
                        content: S.current.report_chart_1_1,
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
                        content: Utils.convertSecondToTime(totalTime),
                        size: 26,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                      TextApp(
                        content: S.current.run_minute,
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
                          content: S.current.run_again.toUpperCase(),
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
                          content: S.current.run_share.toUpperCase(),
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
