import 'dart:convert';

import 'package:women_fitness_flutter/shared/model/description_language.dart';
import 'package:women_fitness_flutter/shared/model/title_language.dart';

class Section {
  int id;
  String title;
  String description;
  String thumb;
  int level;
  int type;
  int status;
  List<String> workoutsId;
  TitleLanguage titleLanguage;
  DescriptionLanguage descriptionLanguage;

  Section.fromData(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    thumb = map['thumb'];
    level = map['level'];
    type = map['type'];
    status = map['status'];
    workoutsId = (json.decode(map['workoutsId']) as List)
        ?.map((e) => e as String)
        ?.toList();
    titleLanguage = TitleLanguage.fromJson(json.decode(map['title_language']));
    descriptionLanguage =
        DescriptionLanguage.fromJson(json.decode(map['description_language']));
  }
}
