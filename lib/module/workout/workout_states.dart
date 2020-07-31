import 'package:equatable/equatable.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class WorkOutState extends Equatable {
  final List<Section> listSections;

  const WorkOutState({this.listSections});

  @override
  List<Object> get props => [];
}

class WorkOutStateInitial extends WorkOutState {}

class WorkOutStateLoading extends WorkOutState {}

class WorkOutStateLoaded extends WorkOutState {
  WorkOutStateLoaded({List<Section> listSections})
      : super(listSections: listSections);
}
