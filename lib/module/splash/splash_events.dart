import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashGetDataEvent extends SplashEvent {
  final bool first;

  SplashGetDataEvent({this.first = false});
}
