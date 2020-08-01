import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class TrainingState {}

class TrainingStateInitial extends TrainingState {}

class TrainingStateGetFavoriteDone extends TrainingState {
  final List<Section> lists;

  TrainingStateGetFavoriteDone({@required this.lists});
}
