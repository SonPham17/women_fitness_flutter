import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/db/hive/challenge_week.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/challenge_week_widget.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ChallengeTrainingPage extends StatefulWidget {
  final List<WorkOut> listWorkOuts;
  final List<Section> listSections;

  ChallengeTrainingPage(
      {@required this.listWorkOuts, @required this.listSections});

  @override
  _ChallengeTrainingPageState createState() => _ChallengeTrainingPageState();
}

class _ChallengeTrainingPageState extends State<ChallengeTrainingPage> {
  int dayFinished = 0;

  @override
  void initState() {
    super.initState();
    var challengeBox = Hive.box('challenge_week');
    dayFinished = challengeBox.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            NestedScrollView(
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: EdgeInsets.all(10),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        ChallengeWeekWidget(
                          listWorkOuts: widget.listWorkOuts,
                          week: 1,
                          listSections: widget.listSections.sublist(18, 25),
                          isWeekSelected: true,
                          dayFinish: dayFinished > 7 ? 7 : dayFinished,
                        ),
                        ChallengeWeekWidget(
                          listWorkOuts: widget.listWorkOuts,
                          week: 2,
                          listSections: widget.listSections.sublist(25, 32),
                          isWeekSelected: dayFinished > 6,
                          dayFinish: dayFinished < 14 ? dayFinished - 7 : 7,
                        ),
                        ChallengeWeekWidget(
                          listWorkOuts: widget.listWorkOuts,
                          week: 3,
                          listSections: widget.listSections.sublist(32, 39),
                          isWeekSelected: dayFinished > 13,
                          dayFinish: dayFinished < 21 ? dayFinished - 14 : 7,
                        ),
                        ChallengeWeekWidget(
                          listWorkOuts: widget.listWorkOuts,
                          week: 4,
                          listSections: widget.listSections.sublist(39, 46),
                          isWeekSelected: dayFinished > 20,
                          dayFinish: dayFinished < 28 ? dayFinished - 21 : 7,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ]),
                    ),
                  )
                ],
              ),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200,
                    forceElevated: innerBoxIsScrolled,
                    floating: false,
                    pinned: true,
                    centerTitle: false,
                    title: TextApp(
                      content: S.current.training_7x4,
                      fontWeight: FontWeight.bold,
                    ),
                    flexibleSpace: _buildFlexible(),
                  ),
                ];
              },
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: SizeConfig.screenWidth,
                height: 70,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: FlatButton(
                  padding: EdgeInsets.all(10),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: AppColor.main,
                  onPressed: () {
//                  Navigator.of(context).pop(weeklyTraining);
                  },
                  child: Center(
                    child: TextApp(
                      content: S.current.training_go.toUpperCase(),
                      size: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlexible() => FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        background: Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 100,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fullbodyworkout.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextApp(
                content:
                    '${S.current.challenge_progress} ${((dayFinished / 28) * 100).toStringAsFixed(2)}%',
                textColor: Colors.white,
                size: SizeConfig.defaultSize * 2,
              ),
              SizedBox(
                height: 10,
              ),
              TextApp(
                content: '${28 - dayFinished} ${S.current.challenge_day_left}',
                textColor: Colors.white,
                size: SizeConfig.defaultSize * 2,
              ),
              SizedBox(
                height: 15,
              ),
              LinearPercentIndicator(
                width: SizeConfig.screenWidth - 30,
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
            ],
          ),
        ),
      );
}
