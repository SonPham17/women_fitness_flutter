import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:women_fitness_flutter/db/women_fitness_database.dart';
import 'package:women_fitness_flutter/db/work_out_provider.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/challenge.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class FavoriteTrainingPage extends StatefulWidget {
  @override
  _FavoriteTrainingPageState createState() => _FavoriteTrainingPageState();
}

class _FavoriteTrainingPageState extends State<FavoriteTrainingPage> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

//    var map = json.decode(listData[0].descriptionLanguage);
//    print(map);
  }

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
                      delegate: SliverChildListDelegate([]),
                    ),
                  )
                ],
              ),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 180,
                    forceElevated: innerBoxIsScrolled,
                    floating: false,
                    pinned: true,
                    centerTitle: false,
                    title: TextApp(
                      content: 'ABS BEGINNER',
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
                      content: 'START',
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

  Widget _buildFlexible() => FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        background: Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 130,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/favorite_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.flash_on,
                    size: 20,
                    color: Colors.white,
                  ),
                  TextApp(
                    content: '19 workouts',
                    textColor: Colors.white,
                    size: SizeConfig.defaultSize * 1.8,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextApp(
                content: 'Don\'t tell people your plans, show them your body',
                textColor: Colors.white,
                size: SizeConfig.defaultSize * 1.4,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );
}
