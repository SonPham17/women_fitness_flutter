import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/module/run/workout/run_workout_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class RunSplashPage extends StatefulWidget {
  final List<WorkOut> listWorkOutBySection;
  final int index;

  RunSplashPage({@required this.listWorkOutBySection, @required this.index});

  @override
  _RunSplashPageState createState() => _RunSplashPageState();
}

class _RunSplashPageState extends State<RunSplashPage>
    with WidgetsBindingObserver {
  final assetsAudioPlayer = AssetsAudioPlayer();
  FlutterTts flutterTts;
  WorkOut workOut;

  dynamic languages;

  bool isPaused = false;
  double timerProgress = 0.0;
  double rate = 0.5;
  int timeSecond;
  Timer _timer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      assetsAudioPlayer.play();
      isPaused = false;
//      flutterTts.startHandler();
    } else if (state == AppLifecycleState.paused) {
      // user is about quit our app temporally
      assetsAudioPlayer.pause();
      isPaused = true;
//      flutterTts.pauseHandler();
      print('paused');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    workOut = widget.listWorkOutBySection[widget.index];

    if (widget.index == 0) {
      timeSecond = 15;
    } else {
      timeSecond = 30;
    }

    initTts();

    assetsAudioPlayer.open(
      Audio('assets/audio/play_background.mp3'),
    );

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          if (timeSecond == 3) {
            flutterTts.speak('Three');
          }
          if (timeSecond == 2) {
            flutterTts.speak('Two');
          }
          if (timeSecond == 1) {
            flutterTts.speak('One');
          }

          if (timeSecond < 1) {
            deactivate();
            pushNewScreen(
              context,
              screen: RunWorkOutPage(
                listWorkOutBySection: widget.listWorkOutBySection,
                index: widget.index,
              ),
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
              withNavBar: false,
            );
          } else {
            timeSecond--;
            timerProgress = timerProgress + 1 / (widget.index == 0 ? 15 : 30);
          }
        });
      }
    });

    _speak();
  }

  Future<void> initTts() async {
    flutterTts = FlutterTts();
//    flutterTts.setLanguage('vi-VN');

    languages = await flutterTts.getLanguages;

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        rate = 0.9;
        var engines = await flutterTts.getEngines;
        if (engines != null) {
          for (dynamic engine in engines) {
            print(engine);
          }
        }
      }
    }
  }

  Future<void> _speak() async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(1.0);

    flutterTts.speak('Ready to go. Start with ${workOut.title}.');
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
                        'assets/data/${widget.listWorkOutBySection[widget.index].anim}_0.gif',
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
                                '${widget.index + 1}/${widget.listWorkOutBySection.length} ${widget.listWorkOutBySection[widget.index].title.toUpperCase()} ${widget.listWorkOutBySection[widget.index].type == 0 ? Utils.convertSecondToTime(widget.listWorkOutBySection[widget.index].timeDefault) : 'x${widget.listWorkOutBySection[widget.index].countDefault}'}'
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
                  Opacity(
                    child: TextApp(
                      content: 'READY TO GO',
                      textColor: Colors.white,
                      size: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    opacity: widget.index == 0 ? 1 : 0,
                  ),
                  Opacity(
                    opacity: widget.index == 0 ? 0 : 1,
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
                        opacity: widget.index == 0 ? 0 : 1,
                        child: Material(
                          child: Ink(
                            child: InkWell(
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 40,
                              ),
                              onTap: () {
                                deactivate();
                                pushNewScreen(
                                  context,
                                  screen: RunWorkOutPage(
                                    listWorkOutBySection:
                                        widget.listWorkOutBySection,
                                    index: widget.index - 1,
                                  ),
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                  withNavBar: false,
                                );
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
                              deactivate();
                              pushNewScreen(
                                context,
                                screen: RunWorkOutPage(
                                  listWorkOutBySection:
                                      widget.listWorkOutBySection,
                                  index: widget.index,
                                ),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
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
  void deactivate() {
    super.deactivate();
    _timer.cancel();
    assetsAudioPlayer.dispose();
    flutterTts.stop();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
