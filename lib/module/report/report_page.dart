import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/report/report_bloc.dart';
import 'package:women_fitness_flutter/module/report/report_states.dart';
import 'package:women_fitness_flutter/module/training/week_goal/calendar_week_goal_page.dart';
import 'package:women_fitness_flutter/module/training/week_goal/edit_week_goal_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/bar_chart_fitness.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_edit.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  ReportBloc _reportBloc;

  String weekTraining = '4';
  double calculatorBMI;
  String statusWeight;
  String currentHeight = '195 CM';

  DateTime startDate = DateTime.now().subtract(Duration(days: 2));
  DateTime endDate = DateTime.now().add(Duration(days: 2));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 2));
  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];

  double calBMI() {
    if (calculatorBMI < 13.5) {
      calculatorBMI = 13.5;
    } else if (calculatorBMI > 40.5) {
      calculatorBMI = 40.5;
    }
    double f = (calculatorBMI - 13.5) / 27.0;
    var a = ((SizeConfig.screenWidth - 48) * f).toInt() - 2;
    return a.toDouble();
  }

  @override
  void initState() {
    super.initState();
    print("startDate= $startDate");
    print("endDate= $endDate");
    _reportBloc = Injector.resolve<ReportBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    calculatorBMI =
        double.parse(Utils.calculatorBMI(195, 90).toStringAsFixed(1));
    if (calculatorBMI < 18.5) {
      statusWeight = 'Underweight';
    } else if (calculatorBMI >= 18.5 && calculatorBMI < 25.0) {
      statusWeight = 'Normal weight';
    } else if (calculatorBMI < 25.0 || calculatorBMI >= 30.0) {
      statusWeight = 'Obesity';
    } else {
      statusWeight = 'Overweight';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocProvider<ReportBloc>(
          create: (_) => _reportBloc,
          child: BlocConsumer<ReportBloc, ReportState>(
            listener: (context, state) {
              print(state.runtimeType);
              if (state is ReportStateSaveEmpty) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: TextApp(
                      content: 'Weight and Height is empty',
                    ),
                    backgroundColor: AppColor.main,
                    duration: Duration(seconds: 1),
                  ),
                );
                Future.delayed(Duration(seconds: 2), () {
                  Scaffold.of(context).hideCurrentSnackBar();
                });
              }
            },
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTotal(),
                Divider(),
                _buildWeekGoal(context),
                Divider(),
                _buildBMI(),
                Divider(),
                _buildHeight(),
                Divider(),
                _buildChart('Calories burned, estimated', 'Calories'),
                Divider(),
                _buildChart('Exercises', 'Number'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChart(String title, String titleCard) => Container(
        margin: EdgeInsets.only(left: 14, right: 14, bottom: 20, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              content: title,
              textColor: Colors.black,
              size: 17,
            ),
            SizedBox(
              height: 20,
            ),
            BarChartFitness(
              title: titleCard,
            ),
          ],
        ),
      );

  Widget _buildHeight() => Container(
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
                        reportBloc: _reportBloc,
                      ),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          double weight = double.parse(value[0]);
                          double height = double.parse(value[1]);
                          if (!value[2]) {
                            weight = Utils.convertLbsToKg(weight);
                            height = Utils.convertFtToCm(height);
                            currentHeight = '$height FT';
                          } else {
                            currentHeight = '$height CM';
                          }
                          calculatorBMI = double.parse(
                              Utils.calculatorBMI(height, weight)
                                  .toStringAsFixed(1));
                          if (calculatorBMI < 18.5) {
                            statusWeight = 'Underweight';
                          } else if (calculatorBMI >= 18.5 &&
                              calculatorBMI < 25.0) {
                            statusWeight = 'Normal weight';
                          } else if (calculatorBMI < 25.0 ||
                              calculatorBMI >= 30.0) {
                            statusWeight = 'Obesity';
                          } else {
                            statusWeight = 'Overweight';
                          }
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            Row(
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
                      content: '$currentHeight',
                      textColor: Colors.black26,
                      size: 17,
                    ),
                  ),
                  onTap: () {
                    print('edit');
                  },
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildBMI() => Container(
        margin: EdgeInsets.only(left: 14, right: 14),
        child: Column(
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
                        reportBloc: _reportBloc,
                      ),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          double weight = double.parse(value[0]);
                          double height = double.parse(value[1]);
                          if (!value[2]) {
                            weight = Utils.convertLbsToKg(weight);
                            height = Utils.convertFtToCm(height);
                            currentHeight = '$height FT';
                          } else {
                            currentHeight = '$height CM';
                          }
                          calculatorBMI = double.parse(
                              Utils.calculatorBMI(height, weight)
                                  .toStringAsFixed(1));
                          if (calculatorBMI < 18.5) {
                            statusWeight = 'Underweight';
                          } else if (calculatorBMI >= 18.5 &&
                              calculatorBMI < 25.0) {
                            statusWeight = 'Normal weight';
                          } else if (calculatorBMI < 25.0 ||
                              calculatorBMI >= 30.0) {
                            statusWeight = 'Obesity';
                          } else {
                            statusWeight = 'Overweight';
                          }
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
        ),
      );

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black;
    TextStyle normalStyle = TextStyle(
        fontSize: SizeConfig.defaultSize * 1.8,
        fontWeight: FontWeight.w600,
        color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: SizeConfig.defaultSize * 1.8,
        fontWeight: FontWeight.w600,
        color: Colors.black87);
    TextStyle dayNameStyle =
        TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: fontColor);

    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.defaultSize * 1.5,
        ),
        Text(dayName, style: dayNameStyle),
        SizedBox(
          height: SizeConfig.defaultSize,
        ),
        Container(
          width: SizeConfig.defaultSize * 4.4,
          height: SizeConfig.defaultSize * 4.4,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 1, color: AppColor.main, style: BorderStyle.solid)),
          child: Center(
            child: Text(date.day.toString(),
                style: !isSelectedDate ? normalStyle : selectedStyle),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekGoal(BuildContext context) => Container(
        height: SizeConfig.defaultSize * 20,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                left: 20,
                bottom: 10,
              ),
              child: Row(
                children: <Widget>[
                  TextApp(
                    content: 'WEEK GOAL',
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  Container(
                    height: 30,
                    width: 60,
                    child: InkWell(
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: EditWeekGoalPage(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                          withNavBar: false,
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              weekTraining = value;
                            });
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextApp(
                            content: '0/$weekTraining',
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: CalendarWeekGoalPage(),
                    settings: RouteSettings(
                      name: '/training/week_goal/calendar_week_goal',
                      arguments: {
                        'test': 123,
                      },
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: CalendarStrip(
                  startDate: startDate,
                  endDate: endDate,
                  onDateSelected: (date) {
                    pushNewScreenWithRouteSettings(
                      context,
                      screen: CalendarWeekGoalPage(),
                      settings: RouteSettings(
                        name: '/training/week_goal/calendar_week_goal',
                        arguments: {
                          'test': 123,
                        },
                      ),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  dateTileBuilder: dateTileBuilder,
                  iconColor: Colors.black87,
                  monthNameWidget: (monthName) => Container(
                    child: TextApp(
                      content: monthName,
                      size: SizeConfig.defaultSize * 2,
                      textColor: AppColor.main,
                    ),
                    padding: EdgeInsets.only(top: 8, bottom: 4),
                  ),
                  markedDates: markedDates,
                  containerDecoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildTotal() => Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                left: 20,
                bottom: 10,
              ),
              child: TextApp(
                content: 'TOTAL',
                size: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextApp(
                      content: '0',
                      size: 30,
                      textColor: AppColor.main,
                    ),
                    TextApp(
                      content: 'WORKOUTS',
                      size: 18,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextApp(
                      content: '0',
                      size: 30,
                      textColor: AppColor.main,
                    ),
                    TextApp(
                      content: 'KCAL',
                      size: 18,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextApp(
                      content: '0',
                      size: 30,
                      textColor: AppColor.main,
                    ),
                    TextApp(
                      content: 'MINUTES',
                      size: 18,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _reportBloc.close();
  }
}
