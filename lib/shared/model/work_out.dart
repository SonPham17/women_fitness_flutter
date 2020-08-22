import 'dart:convert';

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

  WorkOut(
      this.id,
      this.title,
      this.description,
      this.timeDefault,
      this.countDefault,
      this.video,
      this.anim,
      this.type,
      this.isTwoSides,
      this.calories,
      this.group,
      this.titleLanguage,
      this.descriptionLanguage);

  void updateDataModel(WorkOut workOut){
    this.id = workOut.id;
    this.title = workOut.title;
    this.description = workOut.description;
    this.timeDefault = workOut.timeDefault;
    this.countDefault = workOut.countDefault;
    this.video = workOut.video;
    this.anim = workOut.anim;
    this.type = workOut.type;
    this.isTwoSides = workOut.isTwoSides;
    this.calories = workOut.calories;
    this.group = workOut.group;
    this.titleLanguage = workOut.titleLanguage;
    this.descriptionLanguage = workOut.descriptionLanguage;
  }

  WorkOut.copyModel(WorkOut workOut) {
    id = workOut.id;
    title = workOut.title;
    description = workOut.description;
    timeDefault = workOut.timeDefault;
    countDefault = workOut.countDefault;
    anim = workOut.anim;
    video = workOut.video;
    type = workOut.type;
    isTwoSides = workOut.isTwoSides;
    calories = workOut.calories;
    group = workOut.group;
    titleLanguage = workOut.titleLanguage;
    descriptionLanguage = workOut.descriptionLanguage;
  }

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
    titleLanguage = TitleLanguage.fromJson(
        json.decode(map['title_language'].toString().replaceAll("\n", "\\n")));
    descriptionLanguage = DescriptionLanguage.fromJson(json.decode(
        map['description_language'].toString().replaceAll("\n", "\\n")));
  }
}
