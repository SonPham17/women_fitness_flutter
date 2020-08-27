import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:women_fitness_flutter/db/hive/section_history.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class CalendarWeekGoalPage extends StatefulWidget {
  final List<Section> listSections;

  CalendarWeekGoalPage({@required this.listSections});

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
          content: S.current.history.toUpperCase(),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              calendarController: _calendarController,
              locale: Intl.getCurrentLocale(),
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
            ValueListenableBuilder(
              valueListenable: Hive.box('section_history').listenable(),
              builder: (_, Box box, __) {
                return ListView.separated(
                  itemCount: box.values.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    SectionHistory history = box.getAt(index);
                    return Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/sections/${history.thumb}.jpg',
                              fit: BoxFit.cover,
                              width: 55,
                              height: 55,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextApp(
                                  content: history.timeFinish,
                                  textColor: Colors.grey,
                                ),
                                TextApp(
                                  content: widget.listSections[index].title
                                      .toUpperCase(),
                                  textColor: Colors.black,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: AppColor.main,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    TextApp(
                                      content: Utils.convertSecondToTime(
                                          history.totalTime),
                                      textColor: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Image.asset(
                                      'assets/images/firecalo.png',
                                      width: 15,
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    TextApp(
                                      content:
                                          '${history.calories.toStringAsFixed(2)} Calo',
                                      textColor: Colors.grey,
                                    )
                                  ],
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                );
              },
            )
          ],
        ),
      ),
    );
  }

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
