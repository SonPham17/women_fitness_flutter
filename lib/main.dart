import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:women_fitness_flutter/db/women_fitness_database.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/home/home_page.dart';
import 'package:women_fitness_flutter/module/run/workout/run_workout_page.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_page.dart';
import 'package:women_fitness_flutter/module/splash/splash_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/supervisor_bloc.dart';

Future<void> main() async {
  //init kiwi
  Injector.setup();
  Bloc.observer = SupervisorBloc();

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await WomenFitnessDatabase.instance.init();
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
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
        '/settings/profile' : (context) => ProfilePage(),
      },
    );
  }
}
