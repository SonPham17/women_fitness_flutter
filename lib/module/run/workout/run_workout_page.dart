import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/module/run/splash/run_splash_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class RunWorkOutPage extends StatefulWidget {
  final List<WorkOut> listWorkOutBySection;
  final int index;

  RunWorkOutPage({@required this.listWorkOutBySection, @required this.index});

  @override
  _RunWorkOutPageState createState() => _RunWorkOutPageState();
}

class _RunWorkOutPageState extends State<RunWorkOutPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  WorkOut workOut;

  final assetsAudioPlayer = AssetsAudioPlayer();
  FlutterTts flutterTts;

  AnimationController _animationController;
  int time;
  double _progressValue;
  Timer _timerProgress;
  bool isPaused = false;

  dynamic languages;
  String language;
  double volume = 1;
  double pitch = 1.0;
  double rate = 0.9;

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
    workOut = widget.listWorkOutBySection[widget.index];

    WidgetsBinding.instance.addObserver(this);

    initTts();

    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    time = workOut.timeDefault;
    _progressValue = 0.0;

    Future.delayed(Duration(seconds: 1), () {
      assetsAudioPlayer.open(
        Audio('assets/audio/play_background.mp3'),
      );
      if (workOut.type == 0) {
        _timerProgress = Timer.periodic(Duration(seconds: 1), (timer) {
          if (!isPaused) {
            setState(() {
              time--;
              _progressValue += 1 / 30;
              if (time == 10) {
                flutterTts.speak('Ten seconds left');
              }
              if (time == 3) {
                flutterTts.speak('three');
              }
              if (time == 2) {
                flutterTts.speak('two');
              }
              if (time == 1) {
                flutterTts.speak('one');
              }
              if (time < 1) {
                timer.cancel();
                pushNewScreen(
                  context,
                  screen: RunSplashPage(
                    listWorkOutBySection: widget.listWorkOutBySection,
                    index: widget.index + 1,
                  ),
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  withNavBar: false,
                );
                deactivate();
              }
            });
          }
        });
      }

      _speak();
    });
  }

  Future<void> initTts() async {
    flutterTts = FlutterTts();
//    flutterTts.setLanguage('vi-VN');

    languages = await flutterTts.getLanguages;

    if (!kIsWeb) {
      if (Platform.isAndroid) {
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
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    flutterTts.speak('Start with ${workOut.title}. Start '
        '${workOut.timeDefault} seconds ${workOut.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .popUntil((route) => route.settings.name == '/home');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.volume_up,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => Transform.rotate(
              angle: _animationController.value * 2.0 * pi,
              child: child,
            ),
            child: IconButton(
              icon: Icon(
                Icons.music_note,
                color: AppColor.main,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                'assets/data/${workOut.anim}_0.gif',
                fit: BoxFit.fill,
                width: double.infinity,
                height: 220,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  workOut.type == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Colors.black,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: '$time"',
                                  style: TextStyle(
                                    color: AppColor.main,
                                  ),
                                ),
                                TextSpan(text: '/${workOut.timeDefault}"'),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextApp(
                            content: '${workOut.title}'.toUpperCase(),
                            textColor: Colors.black,
                            fontWeight: FontWeight.bold,
                            size: 25,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        workOut.type == 1
                            ? TextApp(
                                content: 'X${workOut.countDefault}',
                                textColor: AppColor.main,
                                size: 25,
                              )
                            : SizedBox(),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.lightBlue),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      mainAxisSize: MainAxisSize.max,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  workOut.type == 1
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.chevron_left,
                                size: 50,
                              ),
                              GestureDetector(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: RunSplashPage(
                                      listWorkOutBySection:
                                          widget.listWorkOutBySection,
                                      index: widget.index + 1,
                                    ),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                    withNavBar: false,
                                  );
                                  deactivate();
                                },
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.main),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: RunSplashPage(
                                      listWorkOutBySection:
                                          widget.listWorkOutBySection,
                                      index: widget.index + 1,
                                    ),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                    withNavBar: false,
                                  );
                                  deactivate();
                                },
                                child: Icon(
                                  Icons.chevron_right,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            LinearProgressIndicator(
                              value: _progressValue,
                              minHeight: 70,
                              backgroundColor: Colors.transparent,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(AppColor.main),
                            ),
                            Container(
                              height: 70,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Opacity(
                                    opacity: widget.index == 0 ? 0 : 1,
                                    child: Icon(
                                      Icons.chevron_left,
                                      size: 50,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Icon(
                                    Icons.pause,
                                    size: 50,
                                    color: Colors.black45,
                                  ),
                                  Opacity(
                                    opacity: 0,
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 50,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
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
    if(_timerProgress!=null){
      _timerProgress.cancel();
    }
    assetsAudioPlayer.dispose();
    flutterTts.stop();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
