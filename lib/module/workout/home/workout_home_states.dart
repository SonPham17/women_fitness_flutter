
import 'package:equatable/equatable.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class WorkOutHomeState extends Equatable{
  const WorkOutHomeState();

  @override
  List<Object> get props => [];
}

class WorkOutHomeStateInitial extends WorkOutHomeState{}
class WorkOutHomeStateLoading extends WorkOutHomeState{}
class WorkOutHomeStateLoaded extends WorkOutHomeState{
  final List<Section> listSections;

  WorkOutHomeStateLoaded({this.listSections});
}