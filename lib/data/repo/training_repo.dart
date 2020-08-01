import 'dart:async';

import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

class TrainingRepo {
  Future<List<Section>> getListSectionFavorite(List<Section> lists) async {
    return lists.where((section) => section.isLiked).toList();
  }

  Future<List<WorkOut>> getListWorkOutBySection(
      List<WorkOut> listWorkOuts, Section section) async {
    var listWorkOutBySection = List<WorkOut>();
    section.workoutsId.forEach((workOutId) {
      listWorkOutBySection.add(listWorkOuts
          .firstWhere((element) => element.id == int.parse(workOutId)));
    });
    return listWorkOutBySection;
  }
}
