import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/splash/splash_bloc.dart';
import 'package:women_fitness_flutter/module/splash/splash_events.dart';
import 'package:women_fitness_flutter/module/splash/splash_states.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    _splashBloc = Injector.resolve<SplashBloc>()
      ..add(SplashGetDataEvent(first: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SplashBloc>(
        create: (_) => _splashBloc,
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashStateLoaded) {
              Future.delayed(Duration(seconds: 5), () {
                Navigator.pushReplacementNamed(context, '/home', arguments: {
                  'list_workout': state.listWorkOuts,
                  'list_section': state.listSections,
                });
              });
            }
          },
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                Image.asset(
                  'assets/images/splash_bg.jpg',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _splashBloc.close();
  }
}
