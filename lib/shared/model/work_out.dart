import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:women_fitness_flutter/shared/model/description_language.dart';
import 'package:women_fitness_flutter/shared/model/title_language.dart';

class WorkOut {
  int id;
  String title;
  String description;
  int timeDefault;
  int countDefault;
  String video;
  String anim;
  int type;
  int isTwoSides;
  double calories;
  dynamic group;
  TitleLanguage titleLanguage;
  DescriptionLanguage descriptionLanguage;

  WorkOut.fromData(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    timeDefault = map['timeDefault'];
    countDefault = map['countDefault'];
    video = map['video'];
    anim = map['anim'];
    type = map['type'];
    isTwoSides = map['isTwoSides'];
    calories = map['calories'];
    group = map['group'];
    titleLanguage = TitleLanguage.fromJson(json.decode(map['title_language'].toString().replaceAll("\n","\\n")));
    descriptionLanguage =
        DescriptionLanguage.fromJson(json.decode(map['description_language'].toString().replaceAll("\n","\\n")));
  }
}
