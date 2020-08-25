import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class RunFinishState{}

class RunFinishStateInitial extends RunFinishState{}

class RunFinishStateGetAllSectionDone extends RunFinishState{
  List<Section> listSections;

  RunFinishStateGetAllSectionDone({this.listSections});
}