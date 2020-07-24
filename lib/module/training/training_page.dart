import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/module/training/week_goal/edit_week_goal_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class TrainingPage extends StatefulWidget {
  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 2));
  DateTime endDate = DateTime.now().add(Duration(days: 2));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 2));
  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTotal(),
            Divider(),
            _buildWeekGoal(context),
            Divider(),
            _buildChallenge(),
            Divider(),
            _buildFavorite(),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorite() {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: defaultSize),
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
              content: 'FAVORITE',
              size: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          AspectRatio(
            aspectRatio: 1.65,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultSize),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/favorite_bg.jpg',
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: defaultSize * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextApp(
                      content: 'START YOUR',
                      textColor: Colors.white,
                      size: defaultSize * 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                    TextApp(
                      content: 'WORKOUT',
                      textColor: Colors.white,
                      size: defaultSize * 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: defaultSize,
                    ),
                    Container(
                      width: defaultSize * 12,
                      height: defaultSize * 4.5,
                      decoration: BoxDecoration(
                          color: AppColor.main,
                          borderRadius: BorderRadius.circular(defaultSize * 2)),
                      child: Center(
                        child: TextApp(
                          content: 'GO!',
                          size: defaultSize * 2,
                          textColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: defaultSize,
          ),
          Center(
            child: TextApp(
              content: 'Your favorite workouts will be shown here \u{1F49A}',
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChallenge() {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
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
              content: '7X4 CHALLENGE',
              size: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          AspectRatio(
            aspectRatio: 1.65,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultSize),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/images/fullbodyworkout.jpg',
                      ))),
              child: Container(
                margin: EdgeInsets.only(left: defaultSize * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextApp(
                      content: 'FULL BODY',
                      textColor: Colors.white,
                      size: defaultSize * 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                    TextApp(
                      content: '7X4 CHALLENGE',
                      textColor: Colors.white,
                      size: defaultSize * 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: defaultSize,
                    ),
                    Container(
                      width: defaultSize * 12,
                      height: defaultSize * 4.5,
                      decoration: BoxDecoration(
                          color: AppColor.main,
                          borderRadius: BorderRadius.circular(defaultSize * 2)),
                      child: Center(
                        child: TextApp(
                          content: 'START',
                          size: defaultSize * 2,
                          textColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                        );
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
                            content: '0/3',
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: CalendarStrip(
                startDate: startDate,
                endDate: endDate,
                onDateSelected: null,
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
}
