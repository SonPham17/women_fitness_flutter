import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:women_fitness_flutter/db/women_fitness_database.dart';
import 'package:women_fitness_flutter/module/home/home_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';

void main() async{
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
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (context) => HomePage(),
      },
    );
  }
}
