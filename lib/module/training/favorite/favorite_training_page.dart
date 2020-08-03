import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_bloc.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_item_workout.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

import 'favorite_training_events.dart';

class FavoriteTrainingPage extends StatefulWidget {
  final Section section;
  final List<WorkOut> listWorkOuts;

  FavoriteTrainingPage({@required this.section, @required this.listWorkOuts});

  @override
  _FavoriteTrainingPageState createState() => _FavoriteTrainingPageState();
}

class _FavoriteTrainingPageState extends State<FavoriteTrainingPage> {
  FavoriteTrainingBloc _favoriteTrainingBloc;
  List<WorkOut> listWorkOutBySection;

  @override
  void initState() {
    super.initState();
    _favoriteTrainingBloc = Injector.resolve<FavoriteTrainingBloc>()
      ..add(
        FavoriteTrainingGetWorkOutBySectionEvent(
          section: widget.section,
          listWorkOuts: widget.listWorkOuts,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<FavoriteTrainingBloc>(
        create: (_) => _favoriteTrainingBloc,
        child: BlocConsumer<FavoriteTrainingBloc, FavoriteTrainingState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FavoriteTrainingStateInitial) {
              return SizedBox();
            } else if (state is FavoriteTrainingStateGetWorkOutBySectionDone) {
              listWorkOutBySection = state.listWorkOutBySection;
            }
            return Container(
              child: Stack(
                children: <Widget>[
                  NestedScrollView(
                    body: CustomScrollView(
                      slivers: <Widget>[
                        SliverPadding(
                          padding: EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 62),
                          sliver: SliverFixedExtentList(
                            itemExtent: 110,
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => _buildItemWorkOut(
                                  listWorkOutBySection[index]),
                              childCount: listWorkOutBySection.length,
                            ),
                          ),
                        )
                      ],
                    ),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight: 180,
                          forceElevated: innerBoxIsScrolled,
                          floating: false,
                          pinned: true,
                          centerTitle: false,
                          title: TextApp(
                            content: widget.section.title.toUpperCase(),
                            fontWeight: FontWeight.bold,
                          ),
                          flexibleSpace: _buildFlexible(),
                          actions: <Widget>[
                            InkWell(
                              child: Container(
                                child: Icon(Icons.sort),
                                padding: EdgeInsets.all(10),
                              ),
                              onTap: () {
                                print('sort');
                              },
                            )
                          ],
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
                            content: 'START',
                            size: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemWorkOut(WorkOut workOut) => Container(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogItemWorkOut(
                    workOut: workOut,
                  ),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      workOut = value;
                    });
                  }
                });
              },
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/data/${workOut.anim}_0.gif',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextApp(
                          content: workOut.title.toUpperCase(),
                          size: 19,
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        TextApp(
                          content: workOut.timeDefault == 0
                              ? 'x${workOut.countDefault}'
                              : '00:${workOut.timeDefault}',
                          textColor: AppColor.main,
                          size: 17,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(),
          ],
        ),
      );

  Widget _buildFlexible() => FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        background: Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 130,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/sections/${widget.section.thumb}.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.flash_on,
                    size: 20,
                    color: Colors.white,
                  ),
                  TextApp(
                    content: '${widget.section.workoutsId.length} workouts',
                    textColor: Colors.white,
                    size: SizeConfig.defaultSize * 1.8,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextApp(
                content: widget.section.description,
                textColor: Colors.white,
                size: SizeConfig.defaultSize * 1.4,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _favoriteTrainingBloc.close();
  }
}
