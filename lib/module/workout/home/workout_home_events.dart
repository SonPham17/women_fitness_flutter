import 'package:equatable/equatable.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class WorkOutHomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WorkOutHomeFetchedEvent extends WorkOutHomeEvent {}

class WorkOutHomeGetDataEvent extends WorkOutHomeEvent {
  final bool first;

  WorkOutHomeGetDataEvent({this.first = false});
}

class WorkOutHomeLikeEvent extends WorkOutHomeEvent{
  final Section section;

  WorkOutHomeLikeEvent({this.section});
}

class WorkOutHomeUnLikeEvent extends WorkOutHomeEvent{
  final Section section;

  WorkOutHomeUnLikeEvent({this.section});
}
