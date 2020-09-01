import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/module/run/workout/run_workout_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/page_container.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class RunSplashPage extends StatefulWidget {
  final List<WorkOut> listWorkOutBySection;
  final Section section;
  final int index;

  RunSplashPage({
    @required this.listWorkOutBySection,
    @required this.index,
    @required this.section,
  });

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
  int timeSecond = 30;
  int currentTime = 30;
  Timer _timer;

  bool mute;
  bool voiceGuide;

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
      SPref.instance.getInt(Utils.sPrefCountdownTime).then((value) {
        setState(() {
          timeSecond = value ?? 15;
          currentTime = timeSecond;
        });
      });
    } else {
      SPref.instance.getInt(Utils.sPrefTimeSet).then((value) {
        setState(() {
          timeSecond = value ?? 30;
          currentTime = timeSecond;
        });
      });
    }

    initTts();

    setSoundFromSetting();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          if (!mute) {
            if (currentTime == 3) {
              flutterTts.speak(S.current.run_3);
            }
            if (currentTime == 2) {
              flutterTts.speak(S.current.run_2);
            }
            if (currentTime == 1) {
              flutterTts.speak(S.current.run_1);
            }
          }

          if (currentTime < 1) {
            deactivate();
            pushNewScreen(
              context,
              screen: RunWorkOutPage(
                section: widget.section,
                listWorkOutBySection: widget.listWorkOutBySection,
                index: widget.index,
              ),
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
              withNavBar: false,
            );
          } else {
            currentTime--;
            timerProgress = timerProgress + 1 / timeSecond;
          }
        });
      }
    });
  }

  Future<void> setSoundFromSetting() async {
    mute = await SPref.instance.getBool(Utils.sPrefSoundMute) ?? false;
    voiceGuide =
        await SPref.instance.getBool(Utils.sPrefSoundVoiceGuide) ?? true;

    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(1.0);

    if (!mute) {
      assetsAudioPlayer.open(
        Audio('assets/audio/play_background.mp3'),
      );
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
    flutterTts.speak('${S.current.run_ready} ${workOut.title}.');
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Container(
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
                            content: S.current.run_next.toUpperCase(),
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
                      content: S.current.run_ready_go.toUpperCase(),
                      textColor: Colors.white,
                      size: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    opacity: widget.index == 0 ? 1 : 0,
                  ),
                  Opacity(
                    opacity: widget.index == 0 ? 0 : 1,
                    child: TextApp(
                      content: S.current.run_take_a_rest.toUpperCase(),
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
                                    section: widget.section,
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
                          content: '$currentTime',
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
                                  section: widget.section,
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
