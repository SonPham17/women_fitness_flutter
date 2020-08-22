import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_page.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_page.dart';
import 'package:women_fitness_flutter/module/workout/workout_bloc.dart';
import 'package:women_fitness_flutter/module/workout/workout_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

class WorkoutPage extends StatefulWidget {
  final List<Section> listSections;
  final List<WorkOut> listWorkOuts;

  WorkoutPage({@required this.listSections, @required this.listWorkOuts});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final controller = PageController();
  WorkOutBloc _workOutBloc;

  @override
  void initState() {
    super.initState();
    _workOutBloc = Injector.resolve<WorkOutBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: listTab.length,
        initialIndex: 0,
        child: Column(children: <Widget>[
          Container(
            color: AppColor.main,
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                fontFamily: 'OpenSans',
              ),
              tabs: listTab
                  .map(
                    (item) => Tab(
                      text: item.title,
                    ),
                  )
                  .toList(),
            ),
          ),
          BlocProvider<WorkOutBloc>(
            create: (_) => _workOutBloc,
            child: BlocConsumer<WorkOutBloc, WorkOutState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      WorkOutHomePage(
                        listSections: widget.listSections,
                        listWorkOuts: widget.listWorkOuts,
                      ),
                      WorkOutRoutinesPage(
                        listSections: widget.listSections,
                        listWorkOuts: widget.listWorkOuts,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _workOutBloc.close();
  }
}

class ItemTabBar {
  final String title;
  final IconData iconData;

  const ItemTabBar({this.title, this.iconData});
}

final List<ItemTabBar> listTab = [
  ItemTabBar(title: S.current.workout_1.toUpperCase(), iconData: Icons.fitness_center),
  ItemTabBar(title: S.current.workout_2.toUpperCase(), iconData: Icons.add_alert),
];
