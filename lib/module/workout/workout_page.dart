import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_page.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: listTab.length,
        initialIndex: 0,
        child: Column(
          children: <Widget>[
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
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  WorkOutHomePage(),
                  WorkOutRoutinesPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemTabBar {
  final String title;
  final IconData iconData;

  const ItemTabBar({this.title, this.iconData});
}

const List<ItemTabBar> listTab = [
  ItemTabBar(title: 'WORKOUTS', iconData: Icons.fitness_center),
  ItemTabBar(title: 'ROUTINES', iconData: Icons.add_alert),
];
