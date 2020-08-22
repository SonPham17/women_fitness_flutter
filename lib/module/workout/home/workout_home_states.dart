import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class WorkOutHomeState {
  final List<Section> listSections;

  const WorkOutHomeState({this.listSections});

}

class WorkOutHomeStateInitial extends WorkOutHomeState {}

class WorkOutHomeStateLoading extends WorkOutHomeState {}

class WorkOutHomeStateLoaded extends WorkOutHomeState {
  WorkOutHomeStateLoaded({List<Section> listSections})
      : super(listSections: listSections);
}

class WorkOutHomeStateRefresh extends WorkOutHomeState{}
