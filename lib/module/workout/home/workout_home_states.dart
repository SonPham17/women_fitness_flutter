import 'package:equatable/equatable.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class WorkOutHomeState extends Equatable {
  final List<Section> listSections;

  const WorkOutHomeState({this.listSections});

  @override
  List<Object> get props => [];
}

class WorkOutHomeStateInitial extends WorkOutHomeState {}

class WorkOutHomeStateLoading extends WorkOutHomeState {}

class WorkOutHomeStateLoaded extends WorkOutHomeState {
  WorkOutHomeStateLoaded({List<Section> listSections})
      : super(listSections: listSections);
}
