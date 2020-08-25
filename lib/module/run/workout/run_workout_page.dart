import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/module/run/finish/run_finish_page.dart';
import 'package:women_fitness_flutter/module/run/splash/run_splash_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_sound_option.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class RunWorkOutPage extends StatefulWidget {
  final List<WorkOut> listWorkOutBySection;
  final Section section;
  final int index;

  RunWorkOutPage({
    @required this.listWorkOutBySection,
    @required this.index,
    @required this.section,
  });

  @override
  _RunWorkOutPageState createState() => _RunWorkOutPageState();
}

class _RunWorkOutPageState extends State<RunWorkOutPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  WorkOut workOut;

  final assetsAudioPlayer = AssetsAudioPlayer();
  FlutterTts flutterTts;

  AnimationController _animationController;
  bool isPlayingAnimation = true;
  int time;
  double _progressValue;
  Timer _timerProgress;
  bool isPaused = false;

  dynamic languages;
  String language;
  double volume = 1;
  double pitch = 1.0;
  double rate = 0.5;
  List<int> listInt;

  bool mute;
  bool voiceGuide;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      assetsAudioPlayer.play();
      isPaused = false;
    } else if (state == AppLifecycleState.paused) {
      // user is about quit our app temporally
      assetsAudioPlayer.pause();
      isPaused = true;
      print('paused');
    }
  }

  @override
  void initState() {
    super.initState();
    workOut = widget.listWorkOutBySection[widget.index];
    listInt = List<int>.generate(
        widget.listWorkOutBySection.length, (index) => index);

    WidgetsBinding.instance.addObserver(this);

    initTts();

    setSoundFromSetting();

    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    time = workOut.timeDefault;
    _progressValue = 0.0;

    Future.delayed(Duration(seconds: 1), () {
      if (workOut.type == 0) {
        _timerProgress = Timer.periodic(Duration(seconds: 1), (timer) {
          if (!isPaused) {
            setState(() {
              time--;
              _progressValue += 1 / workOut.timeDefault;
              if (!mute) {
                if (time == 10) {
                  flutterTts.speak(S.current.run_10);
                }
                if (time == 3) {
                  flutterTts.speak(S.current.run_3);
                }
                if (time == 2) {
                  flutterTts.speak(S.current.run_2);
                }
                if (time == 1) {
                  flutterTts.speak(S.current.run_1);
                }
              }

              if (time < 1) {
                timer.cancel();
                if (widget.index == widget.listWorkOutBySection.length - 1) {
                  pushNewScreen(
                    context,
                    screen: RunFinishPage(
                      section: widget.section,
                    ),
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    withNavBar: false,
                  );
                } else {
                  pushNewScreen(
                    context,
                    screen: RunSplashPage(
                      section: widget.section,
                      listWorkOutBySection: widget.listWorkOutBySection,
                      index: widget.index + 1,
                    ),
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    withNavBar: false,
                  );
                }
                deactivate();
              }
            });
          }
        });
      }
    });
  }

  Future<void> setSoundFromSetting() async {
    mute = await SPref.instance.getBool(Utils.sPrefSoundMute) ?? false;
    voiceGuide =
        await SPref.instance.getBool(Utils.sPrefSoundVoiceGuide) ?? true;

    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (!mute) {
      assetsAudioPlayer.open(
        Audio('assets/audio/play_background.mp3'),
      );
      assetsAudioPlayer.toggleLoop();
      assetsAudioPlayer.loopMode.listen((loopMode) {
        if (loopMode == LoopMode.none) {
          assetsAudioPlayer.setLoopMode(LoopMode.single);
        }
      });
      if (voiceGuide) {
        _speak();
      } else {
        flutterTts.stop();
      }
    }
  }

  Future<void> initTts() async {
    flutterTts = FlutterTts();

    int indexVoiceLanguage =
        await SPref.instance.getInt(Utils.sPrefIndexVoiceLanguage) ?? 1;

    flutterTts.setLanguage(Utils.listCodeLanguage[indexVoiceLanguage]);

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
    flutterTts.speak(
        '${S.current.run_start_with} ${workOut.title}. ${S.current.run_start} '
        '${workOut.timeDefault} ${S.current.run_seconds} ${workOut.title}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: listInt
                    .map((e) => Expanded(
                          child: Container(
                            margin: widget.listWorkOutBySection.length - 1 ==
                                    listInt.indexOf(e)
                                ? EdgeInsets.only(left: 2)
                                : EdgeInsets.only(right: 2),
                            color: listInt.indexOf(e) < widget.index
                                ? AppColor.main
                                : AppColor.main[200],
                          ),
                        ))
                    .toList(),
              ),
            ),
            Container(
              height: kToolbarHeight,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .popUntil((route) => route.settings.name == '/home');
                    },
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.volume_up,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => DialogSoundOption(),
                      );
                    },
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
                      onPressed: () {
                        if (isPlayingAnimation) {
                          assetsAudioPlayer.pause();
                          _animationController.reset();
                        } else {
                          assetsAudioPlayer.play();
                          _animationController.repeat();
                        }
                        isPlayingAnimation = !isPlayingAnimation;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
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
                                        TextSpan(
                                            text: '/${workOut.timeDefault}"'),
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
                                      shape: BoxShape.circle,
                                      color: Colors.lightBlue),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        child: Icon(
                                          Icons.chevron_left,
                                          size: 50,
                                        ),
                                        onTap: () {
                                          pushNewScreen(
                                            context,
                                            screen: RunWorkOutPage(
                                              section: widget.section,
                                              listWorkOutBySection:
                                                  widget.listWorkOutBySection,
                                              index: widget.index - 1,
                                            ),
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                            withNavBar: false,
                                          );
                                          deactivate();
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          pushNewScreen(
                                            context,
                                            screen: RunSplashPage(
                                              section: widget.section,
                                              listWorkOutBySection:
                                                  widget.listWorkOutBySection,
                                              index: widget.index + 1,
                                            ),
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
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
                                              section: widget.section,
                                              listWorkOutBySection:
                                                  widget.listWorkOutBySection,
                                              index: widget.index + 1,
                                            ),
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColor.main),
                                    ),
                                    Container(
                                      height: 70,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Opacity(
                                            opacity: widget.index == 0 ? 0 : 1,
                                            child: GestureDetector(
                                              child: Icon(
                                                Icons.chevron_left,
                                                size: 50,
                                                color: Colors.black45,
                                              ),
                                              onTap: () {
                                                pushNewScreen(
                                                  context,
                                                  screen: RunWorkOutPage(
                                                    section: widget.section,
                                                    listWorkOutBySection: widget
                                                        .listWorkOutBySection,
                                                    index: widget.index - 1,
                                                  ),
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino,
                                                  withNavBar: false,
                                                );
                                                deactivate();
                                              },
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_timerProgress != null) {
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
