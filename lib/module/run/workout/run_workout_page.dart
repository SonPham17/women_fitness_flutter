import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class RunWorkOutPage extends StatefulWidget {
  final List<WorkOut> listWorkOutBySection;

  RunWorkOutPage({@required this.listWorkOutBySection});

  @override
  _RunWorkOutPageState createState() => _RunWorkOutPageState();
}

class _RunWorkOutPageState extends State<RunWorkOutPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  int time;
  double _progressValue;
  Timer _timerProgress;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
    time = widget.listWorkOutBySection[0].timeDefault;
    _progressValue = 0.0;
    Future.delayed(Duration(seconds: 1), () {
      _timerProgress = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          time--;
          _progressValue += 1/30;
          if (time<1) {
            timer.cancel();
          }
        });
      });
    });
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
                  'assets/data/${widget.listWorkOutBySection[0].anim}_0.gif',
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
                    widget.listWorkOutBySection[0].type == 0
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
                                  TextSpan(
                                      text:
                                          '/${widget.listWorkOutBySection[0].timeDefault}"'),
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
                              content: '${widget.listWorkOutBySection[0].title}'
                                  .toUpperCase(),
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                              size: 25,
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                          widget.listWorkOutBySection[0].type == 1
                              ? TextApp(
                                  content:
                                      'X${widget.listWorkOutBySection[0].countDefault}',
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
                    widget.listWorkOutBySection[0].type == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.chevron_left,
                                size: 50,
                              ),
                              Container(
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
                              Icon(
                                Icons.chevron_right,
                                size: 50,
                              ),
                            ],
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.chevron_left,
                                      size: 50,
                                      color: Colors.black45,
                                    ),
                                    Icon(
                                      Icons.pause,
                                      size: 50,
                                      color: Colors.black45,
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 50,
                                      color: Colors.black45,
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
          )),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _timerProgress.cancel();
    _animationController.dispose();
  }
}
