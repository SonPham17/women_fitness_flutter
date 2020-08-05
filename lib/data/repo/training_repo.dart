import 'dart:async';

import 'package:women_fitness_flutter/data/repo/workout_repo.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

class TrainingRepo {
  WorkOutRepo _workOutRepo;

  TrainingRepo({WorkOutRepo workOutRepo}) : _workOutRepo = workOutRepo;

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

  Future<List<WorkOut>> getListResetWorkOut(Section section) async {
    var listWorkOutReset = await _workOutRepo.getDataMainWorkOut();
    var listWorkOutBySection = List<WorkOut>();
    section.workoutsId.forEach((workOutId) {
      listWorkOutBySection.add(listWorkOutReset
          .firstWhere((element) => element.id == int.parse(workOutId)));
    });
    return listWorkOutBySection;
  }

  Future<WorkOut> getWorkOutByReset(WorkOut workOut) async {
    return _workOutRepo.getWorkOutByReset(workOut);
  }
}
