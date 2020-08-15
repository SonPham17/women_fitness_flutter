import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/home/home_bloc.dart';
import 'package:women_fitness_flutter/module/home/home_events.dart';
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

  String weekTraining = '4';

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
                  return _buildWorkOut(listFavorite, 'FAVORITE');
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
              content: title,
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
                            content: '${section.workoutsId.length} workouts',
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
              content: 'FAVORITE',
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
                            borderRadius:
                                BorderRadius.circular(defaultSize * 2)),
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
            child: InkWell(
              onTap: () {
                pushNewScreenWithRouteSettings(
                  context,
                  screen: ChallengeTrainingPage(
                    listSections : widget.listSections,
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
                            borderRadius:
                                BorderRadius.circular(defaultSize * 2)),
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
    _trainingBloc.close();
    _homeBloc.close();
    _workOutHomeBloc.close();
    _workOutRoutinesBloc.close();
  }
}
