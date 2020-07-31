import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class TrainingState extends Equatable {
  @override
  List<Object> get props => [];
}

class TrainingStateInitial extends TrainingState {}

class TrainingStateGetFavoriteDone extends TrainingState {
  final List<Section> lists;

  TrainingStateGetFavoriteDone({@required this.lists});
}
