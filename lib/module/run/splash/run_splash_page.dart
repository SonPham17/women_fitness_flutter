import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/module/run/workout/run_workout_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class RunSplashPage extends StatefulWidget {
  final List<WorkOut> listWorkOutBySection;

  RunSplashPage({@required this.listWorkOutBySection});

  @override
  _RunSplashPageState createState() => _RunSplashPageState();
}

class _RunSplashPageState extends State<RunSplashPage> {
  double timerProgress = 0.0;
  int timeSecond = 15;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeSecond < 1) {
          timer.cancel();
          pushNewScreen(
            context,
            screen: RunWorkOutPage(
              listWorkOutBySection: widget.listWorkOutBySection,
            ),
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
            withNavBar: false,
          );
        } else {
          timeSecond--;
          timerProgress = timerProgress + 1 / 15;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/splash_ft.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              color: Colors.black45,
              colorBlendMode: BlendMode.darken,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/data/${widget.listWorkOutBySection[0].anim}_0.gif',
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextApp(
                            textColor: Colors.black45,
                            content: 'NEXT',
                            size: 16,
                          ),
                          TextApp(
                            content:
                                '1/${widget.listWorkOutBySection.length} ${widget.listWorkOutBySection[0].title.toUpperCase()} ${widget.listWorkOutBySection[0].type == 0 ? Utils.convertSecondToTime(widget.listWorkOutBySection[0].timeDefault) : 'x${widget.listWorkOutBySection[0].countDefault}'}'
                                    .toUpperCase(),
                            textColor: Colors.black,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                            size: 19,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextApp(
                    content: 'READY TO GO',
                    textColor: Colors.white,
                    size: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  Opacity(
                    opacity: 0,
                    child: TextApp(
                      content: 'take a rest'.toUpperCase(),
                      textColor: Colors.white,
                      size: 17,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Opacity(
                        opacity: 0,
                        child: Material(
                          child: Ink(
                            child: InkWell(
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 40,
                              ),
                              onTap: () {
                                print('left');
                              },
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 6.0,
                        animation: true,
                        animationDuration: 1050,
                        animateFromLastPercent: true,
                        percent: timerProgress,
                        center: TextApp(
                          content: '$timeSecond',
                          textColor: Colors.white,
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        progressColor: AppColor.main,
                      ),
                      Material(
                        child: Ink(
                          child: InkWell(
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 40,
                            ),
                            onTap: () {
                              _timer.cancel();
                              pushNewScreen(
                                context,
                                screen: RunWorkOutPage(
                                  listWorkOutBySection: widget.listWorkOutBySection,
                                ),
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                withNavBar: false,
                              );
                            },
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose run splash');
    _timer.cancel();
  }
}
