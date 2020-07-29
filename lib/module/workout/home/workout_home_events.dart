import 'package:equatable/equatable.dart';

abstract class WorkOutHomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WorkOutHomeFetchedEvent extends WorkOutHomeEvent {}

class WorkOutHomeGetDataEvent extends WorkOutHomeEvent {
  final bool first;

  WorkOutHomeGetDataEvent({this.first = false});
}
