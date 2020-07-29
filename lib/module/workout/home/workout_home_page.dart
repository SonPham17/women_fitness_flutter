import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_bloc.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class WorkOutHomePage extends StatefulWidget {
  @override
  _WorkOutHomePageState createState() => _WorkOutHomePageState();
}

class _WorkOutHomePageState extends State<WorkOutHomePage> {
  WorkOutHomeBloc _workOutHomeBloc;

  @override
  Widget build(BuildContext context) {
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
                content: 'Click \u{2665} to add workouts to the Training page.',
                size: SizeConfig.defaultSize * 1.7,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(),
          _buildAbs(),
        ],
      ),
    );
  }

  Widget _buildAbs() => Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: <Widget>[
            TextApp(
              content: 'ABS WORKOUT',
              textColor: Colors.black,
              size: 15,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      );
}
