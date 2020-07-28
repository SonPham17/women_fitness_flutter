import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ChallengeTrainingPage extends StatefulWidget {
  @override
  _ChallengeTrainingPageState createState() => _ChallengeTrainingPageState();
}

class _ChallengeTrainingPageState extends State<ChallengeTrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            NestedScrollView(
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: EdgeInsets.all(10),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildWeek(),
                        _buildWeek(),
                        _buildWeek(),
                        _buildWeek(),
                        SizedBox(
                          height: 60,
                        ),
                      ]),
                    ),
                  )
                ],
              ),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200,
                    forceElevated: innerBoxIsScrolled,
                    floating: false,
                    pinned: true,
                    centerTitle: false,
                    title: TextApp(
                      content: '7X4 CHALLENGE',
                      fontWeight: FontWeight.bold,
                    ),
                    flexibleSpace: _buildFlexible(),
                  ),
                ];
              },
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: SizeConfig.screenWidth,
                height: 70,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: FlatButton(
                  padding: EdgeInsets.all(10),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: AppColor.main,
                  onPressed: () {
//                  Navigator.of(context).pop(weeklyTraining);
                  },
                  child: Center(
                    child: TextApp(
                      content: 'GO!',
                      size: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeek() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: AppColor.main,
              ),
              SizedBox(
                width: 5,
              ),
              TextApp(
                content: 'WEEK 1',
                textColor: AppColor.main,
              ),
              Spacer(),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '2',
                      style: TextStyle(
                        color: AppColor.main,
                      ),
                    ),
                    TextSpan(text: '/7'),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 12, top: 0),
                width: 1,
                height: 150,
                color: AppColor.main,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[50],
                  ),
                  padding: EdgeInsets.only(
                      top: SizeConfig.defaultSize * 1.5,
                      left: SizeConfig.defaultSize,
                      right: SizeConfig.defaultSize,
                      bottom: SizeConfig.defaultSize * 1.5),
                  margin: EdgeInsets.only(
                    left: SizeConfig.defaultSize * 2,
                    top: SizeConfig.defaultSize,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black54,
                                )),
                            child: Center(
                              child: TextApp(
                                content: '1',
                                size: 18,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black54,
                                )),
                            child: Center(
                              child: TextApp(
                                content: '2',
                                size: 18,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black54,
                                )),
                            child: Center(
                              child: TextApp(
                                content: '3',
                                size: 18,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black54,
                                )),
                            child: Center(
                              child: TextApp(
                                content: '4',
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black54,
                                )),
                            child: Center(
                              child: TextApp(
                                content: '5',
                                size: 18,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black54,
                                )),
                            child: Center(
                              child: TextApp(
                                content: '6',
                                size: 18,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black54,
                                )),
                            child: Center(
                              child: TextApp(
                                content: '7',
                                size: 18,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                          SvgPicture.asset(
                            'assets/svg/trophy.svg',
                            width: 45,
                            height: 45,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      );

  Widget _buildFlexible() => FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        background: Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 100,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fullbodyworkout.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextApp(
                content: 'Progress 90%',
                textColor: Colors.white,
                size: SizeConfig.defaultSize * 2,
              ),
              SizedBox(
                height: 10,
              ),
              TextApp(
                content: '28 Days left',
                textColor: Colors.white,
                size: SizeConfig.defaultSize * 2,
              ),
              SizedBox(
                height: 15,
              ),
              LinearPercentIndicator(
                width: SizeConfig.screenWidth - 30,
                animation: true,
                lineHeight: 15,
                animationDuration: 2000,
                percent: 0.9,
                center: TextApp(
                  content: '90%',
                  size: 10,
                ),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ],
          ),
        ),
      );
}
