import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:women_fitness_flutter/module/home/home_page.dart';
import 'package:women_fitness_flutter/module/training/week_goal/edit_week_goal_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColor.main,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (context) => HomePage(),
        '/training/week_goal/edit_week_goal' : (context) => EditWeekGoalPage(),
      },
    );
  }
}
