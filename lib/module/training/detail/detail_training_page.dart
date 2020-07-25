import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class DetailTrainingPage extends StatefulWidget {
  @override
  _DetailTrainingPageState createState() => _DetailTrainingPageState();
}

class _DetailTrainingPageState extends State<DetailTrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          NestedScrollView(
            body: _buildContent(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  floating: false,
                  pinned: true,
                  centerTitle: false,
                  title: TextApp(
                    content: '7X4 CHALLENGE',
                    fontWeight: FontWeight.bold,
                  ),
                  flexibleSpace: _buildFlexible(),
                )
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
          )
        ],
      ),
    ));
  }

  Widget _buildContent() => Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: AppColor.main,
                ),
                SizedBox(width: 5,),
                TextApp(
                  content: 'WEEK 1',
                  textColor: AppColor.main,
                ),
                Spacer(),
                TextApp(
                  content: '2/7',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12,top: 0),
                  width: 1,
                  height: 150,
                  color: AppColor.main,
                )
              ],
            )

          ],
        ),
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
