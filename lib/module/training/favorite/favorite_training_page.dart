import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_bloc.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
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
            }

            var listWorkOutBySection =
                (state as FavoriteTrainingStateGetWorkOutBySectionDone)
                    .listWorkOutBySection;
            return Container(
              child: Stack(
                children: <Widget>[
                  NestedScrollView(
                    body: CustomScrollView(
                      slivers: <Widget>[
                        SliverPadding(
                          padding: EdgeInsets.all(10),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              Center(
                                child: TextApp(
                                  content: '1231212',
                                ),
                              )
                            ]),
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
