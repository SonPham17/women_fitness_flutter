import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:like_button/like_button.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/db/hive/challenge_week.dart';
import 'package:women_fitness_flutter/db/hive/section_history.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/home/home_bloc.dart';
import 'package:women_fitness_flutter/module/home/home_events.dart';
import 'package:women_fitness_flutter/module/in_app_purchase/IAPPage.dart';
import 'package:women_fitness_flutter/module/training/challenge/challenge_training_page.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_page.dart';
import 'package:women_fitness_flutter/module/training/training_bloc.dart';
import 'package:women_fitness_flutter/module/training/training_events.dart';
import 'package:women_fitness_flutter/module/training/training_states.dart';
import 'package:women_fitness_flutter/module/training/week_goal/calendar_week_goal_page.dart';
import 'package:women_fitness_flutter/module/training/week_goal/edit_week_goal_page.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_bloc.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_events.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_bloc.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_events.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class TrainingPage extends StatefulWidget {
  final List<Section> listSections;
  final List<WorkOut> listWorkOuts;

  TrainingPage({@required this.listSections, this.listWorkOuts});

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  TrainingBloc _trainingBloc;
  WorkOutHomeBloc _workOutHomeBloc;
  WorkOutRoutinesBloc _workOutRoutinesBloc;
  HomeBloc _homeBloc;

  int weekTraining = 0;
  int dayFinished;

  int totalWorkOuts = 0;
  double totalKcal = 0;
  int totalMinutes = 0;

  DateTime startDate = DateTime.now().subtract(Duration(days: 2));
  DateTime endDate = DateTime.now().add(Duration(days: 2));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 2));
  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];

  @override
  void initState() {
    super.initState();

    _trainingBloc = Injector.resolve<TrainingBloc>()
      ..add(TrainingGetSectionFavoriteEvent(listSections: widget.listSections));
    _workOutHomeBloc = Injector.resolve<WorkOutHomeBloc>();
    _workOutRoutinesBloc = Injector.resolve<WorkOutRoutinesBloc>();
    _homeBloc = Injector.resolve<HomeBloc>();

    SPref.instance.getInt(Utils.sPrefWeekGoal).then((value) {
      setState(() {
        weekTraining = value ?? 2;
      });
    });

    var challengeBox = Hive.box('challenge_week');
    if (challengeBox.length == 0) {
      var challengeWeek =
          ChallengeWeek(idSection: 101, title: 'Day 1', index: 0);
      challengeBox.put(101, challengeWeek);
    }
    dayFinished = challengeBox.length - 1;

    _getDataTotal();
  }

  Future<void> _getDataTotal() async {
    var sectionBox = Hive.box('section_history');
    for (int i = 0; i < sectionBox.length; i++) {
      SectionHistory sectionHistory = sectionBox.getAt(i);
      totalKcal += sectionHistory.calories;
      totalMinutes += sectionHistory.totalTime;
    }

    setState(() {
      totalWorkOuts = sectionBox.length;
    });

    sectionBox.watch().listen((event) {
      setState(() {
        totalWorkOuts = sectionBox.length;
        SectionHistory sectionHistory = event.value;
        totalKcal += sectionHistory.calories;
        totalMinutes += sectionHistory.totalTime;
        print('event section box watch= ${sectionHistory.calories}');
      });
    });
  }

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
            MultiBlocProvider(
              providers: [
                BlocProvider<TrainingBloc>(
                  create: (_) => _trainingBloc,
                ),
                BlocProvider<WorkOutHomeBloc>(
                  create: (_) => _workOutHomeBloc,
                ),
                BlocProvider<WorkOutRoutinesBloc>(
                  create: (_) => _workOutRoutinesBloc,
                ),
                BlocProvider<HomeBloc>(
                  create: (_) => _homeBloc,
                ),
              ],
              child: BlocConsumer<TrainingBloc, TrainingState>(
                builder: (context, state) {
                  if (state is TrainingStateInitial) {
                    return _buildFavorite();
                  }

                  var listFavorite =
                      (state as TrainingStateGetFavoriteDone).lists;
                  if (listFavorite.length == 0) {
                    return _buildFavorite();
                  }
                  return _buildWorkOut(
                      listFavorite, S.current.training_favorite);
                },
                listener: (context, state) {
                  if (state is TrainingStateGetFavoriteDone) {
                    print(state.lists.length);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkOut(List<Section> listAbs, String title) => Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextApp(
              content: title.toUpperCase(),
              textColor: Colors.black,
              size: 15,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 15,
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children:
                  listAbs.map((section) => _buildItemWorkOut(section)).toList(),
            ),
          ],
        ),
      );

  Widget _buildItemWorkOut(Section section) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: AspectRatio(
        aspectRatio: 2,
        child: InkWell(
          onTap: () {
            pushNewScreenWithRouteSettings(
              context,
              screen: FavoriteTrainingPage(
                section: section,
                listWorkOuts: widget.listWorkOuts,
              ),
              settings: RouteSettings(
                name: '/training/favorite',
              ),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/sections/${section.thumb}.jpg',
                    ))),
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: LikeButton(
                        onTap: (bool isLiked) async {
                          if (isLiked) {
                            section.isLiked = false;
                            _workOutHomeBloc.add(
                                WorkOutHomeRefreshListEvent(section: section));
                            _workOutRoutinesBloc.add(
                                WorkOutRoutinesRefreshListEvent(
                                    section: section));
                          }
                          return !isLiked;
                        },
                        size: 30,
                        isLiked: section.isLiked,
                        likeBuilder: (isLiked) => Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextApp(
                        content: section.title.toUpperCase(),
                        textColor: Colors.white,
                        size: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.flash_on,
                            size: 20,
                            color: AppColor.main,
                          ),
                          Icon(
                            Icons.flash_on,
                            size: 20,
                            color: section.level == 2
                                ? AppColor.main
                                : (section.level == 3
                                    ? AppColor.main
                                    : Colors.white),
                          ),
                          Icon(
                            Icons.flash_on,
                            size: 20,
                            color: section.level == 3
                                ? AppColor.main
                                : Colors.white,
                          ),
                          TextApp(
                            size: 13,
                            content:
                                '${section.workoutsId.length} ${S.current.training_workouts}',
                            textColor: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
              content: S.current.training_favorite.toUpperCase(),
              size: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              _homeBloc.add(HomeShowTabWorkOutEvent());
            },
            child: AspectRatio(
              aspectRatio: 1.65,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultSize),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/sections/absworkout1.jpg',
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
                        content: S.current.training_start.toUpperCase(),
                        textColor: Colors.white,
                        size: defaultSize * 2.5,
                        fontWeight: FontWeight.bold,
                      ),
                      TextApp(
                        content: S.current.training_workout.toUpperCase(),
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
                            borderRadius:
                                BorderRadius.circular(defaultSize * 2)),
                        child: Center(
                          child: TextApp(
                            content: S.current.training_go.toUpperCase(),
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
          ),
          SizedBox(
            height: defaultSize,
          ),
          Center(
            child: TextApp(
              content: '${S.current.training_bottom} \u{1F49A}',
              textAlign: TextAlign.center,
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
              content: S.current.training_7x4.toUpperCase(),
              size: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          AspectRatio(
            aspectRatio: 1.65,
            child: InkWell(
              onTap: () {
                pushNewScreenWithRouteSettings(
                  context,
                  screen: ChallengeTrainingPage(
                    listSections: widget.listSections,
                    listWorkOuts: widget.listWorkOuts,
                  ),
                  settings: RouteSettings(
                    name: '/training/challenge',
                    arguments: {
                      'test': 123,
                    },
                  ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );

                // pushNewScreen(
                //   context,
                //   screen: IAPPage(),
                //   withNavBar: false,
                //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                // );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultSize),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/images/sections/fullbodyworkout.jpg',
                        ))),
                child: Container(
                  margin: EdgeInsets.only(left: defaultSize * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextApp(
                        content: S.current.training_full_body.toUpperCase(),
                        textColor: Colors.white,
                        size: defaultSize * 2.5,
                        fontWeight: FontWeight.bold,
                      ),
                      TextApp(
                        content: S.current.training_7x4.toUpperCase(),
                        textColor: Colors.white,
                        size: defaultSize * 2.5,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      dayFinished == 0
                          ? Container(
                              width: defaultSize * 12,
                              height: defaultSize * 4.5,
                              decoration: BoxDecoration(
                                  color: AppColor.main,
                                  borderRadius:
                                      BorderRadius.circular(defaultSize * 2)),
                              child: Center(
                                child: TextApp(
                                  content: S.current.training_btn_start
                                      .toUpperCase(),
                                  size: defaultSize * 2,
                                  textColor: Colors.white,
                                ),
                              ),
                            )
                          : _buildProgressChallenge()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressChallenge() => Container(
        margin: EdgeInsets.only(right: 10, top: 10),
        child: LinearPercentIndicator(
          animation: true,
          lineHeight: 15,
          animationDuration: 2000,
          percent: dayFinished / 28,
          center: TextApp(
            content: '${((dayFinished / 28) * 100).toStringAsFixed(2)}%',
            size: 10,
          ),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.greenAccent,
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
                    content: S.current.training_wg.toUpperCase(),
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
                          screen: EditWeekGoalPage(
                            weeklyTraining: weekTraining,
                          ),
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                          withNavBar: false,
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              weekTraining = value;
                              SPref.instance
                                  .setInt(Utils.sPrefWeekGoal, weekTraining);
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
                    screen: CalendarWeekGoalPage(
                      listSections: widget.listSections,
                    ),
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
                      screen: CalendarWeekGoalPage(
                        listSections: widget.listSections,
                      ),
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
                content: S.current.training_total.toUpperCase(),
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
                      content: '$totalWorkOuts',
                      size: 30,
                      textColor: AppColor.main,
                    ),
                    TextApp(
                      content: S.current.training_workouts.toUpperCase(),
                      size: 18,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextApp(
                      content: '${totalKcal.toStringAsFixed(0)}',
                      size: 30,
                      textColor: AppColor.main,
                    ),
                    TextApp(
                      content: S.current.training_kcal.toUpperCase(),
                      size: 18,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextApp(
                      content: '${Utils.convertSecondToTime(totalMinutes)}',
                      size: 30,
                      textColor: AppColor.main,
                    ),
                    TextApp(
                      content: S.current.training_minutes.toUpperCase(),
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
    _trainingBloc.close();
    _homeBloc.close();
    _workOutHomeBloc.close();
    _workOutRoutinesBloc.close();
  }
}
