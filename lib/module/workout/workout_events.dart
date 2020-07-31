
import 'package:equatable/equatable.dart';

abstract class WorkOutEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class WorkOutGetDataEvent extends WorkOutEvent {
  final bool first;

  WorkOutGetDataEvent({this.first = false});
}