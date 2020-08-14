import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class CalendarWeekGoalPage extends StatefulWidget {
  @override
  _CalendarWeekGoalPageState createState() => _CalendarWeekGoalPageState();
}

class _CalendarWeekGoalPageState extends State<CalendarWeekGoalPage>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  String _firstDayOfTheWeek;
  String _endDayOfTheWeek;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    DateTime today = DateTime.now();
    _firstDayOfTheWeek = DateTimeFormat.format(
        getDate(today.subtract(Duration(days: today.weekday - 1))),
        format: 'M j');
    _endDayOfTheWeek = DateTimeFormat.format(
        getDate(
            today.add(Duration(days: DateTime.daysPerWeek - today.weekday))),
        format: 'M j');
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextApp(
          content: 'HISTORY',
        ),
        centerTitle: false,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TableCalendar(
              calendarController: _calendarController,
              locale: 'en_EN',
              initialCalendarFormat: CalendarFormat.month,
              formatAnimation: FormatAnimation.slide,
              startingDayOfWeek: StartingDayOfWeek.monday,
              availableGestures: AvailableGestures.all,
              availableCalendarFormats: const {
                CalendarFormat.month: '',
                CalendarFormat.week: '',
              },
              calendarStyle: CalendarStyle(
                outsideDaysVisible: true,
                weekendStyle: TextStyle(
                  fontFamily: 'OpenSans',
                ).copyWith(color: Colors.green),
                outsideWeekendStyle: TextStyle(
                  fontFamily: 'OpenSans',
                ).copyWith(color: Colors.black26),
                outsideHolidayStyle: TextStyle(
                  fontFamily: 'OpenSans',
                ).copyWith(color: Colors.black26),
                selectedColor: AppColor.main,
                todayColor: AppColor.main[300],
                weekdayStyle: TextStyle(
                  fontFamily: 'OpenSans',
                ).copyWith(color: Colors.black),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(
                  fontFamily: 'OpenSans',
                ).copyWith(color: Colors.black),
                weekdayStyle: TextStyle(
                  fontFamily: 'OpenSans',
                ).copyWith(color: Colors.black),
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                ),
                formatButtonVisible: false,
              ),
              onVisibleDaysChanged: _onVisibleDaysChanged,
              onCalendarCreated: _onCalendarCreated,
            ),
            Divider(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() => Container(
        padding: EdgeInsets.only(
          top: SizeConfig.defaultSize,
          left: SizeConfig.defaultSize * 2,
          right: SizeConfig.defaultSize * 2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextApp(
                  content: '$_firstDayOfTheWeek - $_endDayOfTheWeek',
                  size: SizeConfig.defaultSize * 1.9,
                ),
                TextApp(
                  content: '0 workouts',
                  textColor: Colors.black54,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: AppColor.main,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextApp(
                      content: '00:00',
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/firecalo.png',
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextApp(
                      content: '0.00 Calories',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _calendarController.dispose();
  }
}
