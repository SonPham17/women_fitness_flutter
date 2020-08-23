import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:women_fitness_flutter/db/hive/challenge_week.dart';
import 'package:women_fitness_flutter/db/women_fitness_database.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/first_install/first_install_next_page.dart';
import 'package:women_fitness_flutter/module/first_install/first_install_page.dart';
import 'package:women_fitness_flutter/module/home/home_page.dart';
import 'package:women_fitness_flutter/module/setting/profile/profile_page.dart';
import 'package:women_fitness_flutter/module/splash/splash_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/supervisor_bloc.dart';

Future<void> main() async {
  //init kiwi
  Injector.setup();
  Bloc.observer = SupervisorBloc();

  WidgetsFlutterBinding.ensureInitialized();

  // init db
  await WomenFitnessDatabase.instance.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  //init hive
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ChallengeWeekAdapter());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColor.main,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/first_install': (context) => FirstInstallPage(),
        '/first_install_next': (context) => FirstInstallNextPage(),
        '/home': (context) => HomePage(),
        '/settings/profile': (context) => ProfilePage(),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }
}
