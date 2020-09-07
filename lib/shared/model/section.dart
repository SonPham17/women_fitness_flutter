import 'dart:convert';
import 'dart:io';
import 'package:women_fitness_flutter/data/spref/spref.dart';

class Section{
  int id;
  String title;
  String description;
  String thumb;
  int level;
  int type;
  int status;
  List<String> workoutsId;
  Map<String,dynamic> titleLanguage;
  Map<String,dynamic> descriptionLanguage;
  bool isLiked;

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
    titleLanguage = json.decode(map['title_language']);
    descriptionLanguage =
        json.decode(map['description_language']);

    String languageCode = Platform.localeName.split('_')[0];
    if (languageCode != 'en') {
      title = titleLanguage['$languageCode'] ?? title;
      description = descriptionLanguage['$languageCode'] ?? description;
    }

    SPref.instance.getBool(title).then((value) {
      isLiked = value ?? false;
    });
  }
}
