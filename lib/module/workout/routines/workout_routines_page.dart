import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_bloc.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_events.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class WorkOutRoutinesPage extends StatefulWidget {
  final List<Section> listSections;

  WorkOutRoutinesPage({this.listSections});

  @override
  _WorkOutRoutinesPageState createState() => _WorkOutRoutinesPageState();
}

class _WorkOutRoutinesPageState extends State<WorkOutRoutinesPage>
    with AutomaticKeepAliveClientMixin<WorkOutRoutinesPage> {
  WorkOutRoutinesBloc _workOutRoutinesBloc;

  @override
  void initState() {
    super.initState();
    _workOutRoutinesBloc = Injector.resolve<WorkOutRoutinesBloc>();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocProvider<WorkOutRoutinesBloc>(
      create: (_) => _workOutRoutinesBloc,
      child: BlocConsumer<WorkOutRoutinesBloc, WorkOutRoutinesState>(
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: TextApp(
                      content:
                          'Click \u{2665} to add workouts to the Training page.',
                      size: SizeConfig.defaultSize * 1.7,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Divider(),
                _buildWorkOut(widget.listSections.sublist(10, 12), 'ROUTINE'),
              ],
            ),
          );
        },
        listener: (context, state) {},
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
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: AspectRatio(
        aspectRatio: 2,
        child: InkWell(
          onTap: () {
//        pushNewScreenWithRouteSettings(
//          context,
//          screen: ChallengeTrainingPage(),
//          settings: RouteSettings(
//            name: '/training/challenge',
//            arguments: {
//              'test': 123,
//            },
//          ),
//          withNavBar: false,
//          pageTransitionAnimation: PageTransitionAnimation.cupertino,
//        );
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
                            _workOutRoutinesBloc.add(
                                WorkOutRoutinesUnLikeEvent(section: section));
                          } else {
                            section.isLiked = true;
                            _workOutRoutinesBloc.add(
                                WorkOutRoutinesLikeEvent(section: section));
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

  @override
  void dispose() {
    super.dispose();
    _workOutRoutinesBloc.close();
  }
}
