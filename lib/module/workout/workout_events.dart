import 'package:equatable/equatable.dart';

abstract class WorkOutEvent {}

class WorkOutGetDataEvent extends WorkOutEvent {
  final bool first;

  WorkOutGetDataEvent({this.first = false});
}
