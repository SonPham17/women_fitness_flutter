import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kenburns/kenburns.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/splash/splash_bloc.dart';
import 'package:women_fitness_flutter/module/splash/splash_events.dart';
import 'package:women_fitness_flutter/module/splash/splash_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc _splashBloc;
  double height;
  double weight;

  @override
  void initState() {
    super.initState();
    _splashBloc = Injector.resolve<SplashBloc>()
      ..add(SplashGetDataEvent(first: true));

    getWeightAndHeight();
  }

  Future<void> getWeightAndHeight() async {
    height = await SPref.instance.getDouble(Utils.sPrefHeight);
    weight = await SPref.instance.getDouble(Utils.sPrefWeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SplashBloc>(
        create: (_) => _splashBloc,
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashStateLoaded) {
              Future.delayed(Duration(seconds: 3), () {
                if (height != null && weight != null) {
                  Navigator.pushReplacementNamed(context, '/home', arguments: {
                    'list_workout': state.listWorkOuts,
                    'list_section': state.listSections,
                  });
                } else {
                  Navigator.pushReplacementNamed(context, '/first_install',
                      arguments: {
                        'list_workout': state.listWorkOuts,
                        'list_section': state.listSections,
                      });
                }
              });
            }
          },
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                KenBurns(
                  maxScale: 1.5,
                  child: Image.asset(
                    'assets/images/splash_bg.jpg',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        width: 5,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColor.main,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextApp(
                            content: 'women\'s fitness'.toUpperCase(),
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 27,
                          ),
                          TextApp(
                            size: 18,
                            content: 'Power by FITNESS STUDIO',
                            textColor: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                )
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
