import 'package:flutter/cupertino.dart';
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
    workoutsId = map['workoutsId'];
    titleLanguage = map['title_language'];
    descriptionLanguage = map['description_language'];
  }
}
