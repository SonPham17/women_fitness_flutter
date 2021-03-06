import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

abstract class SplashState {
  final List<Section> listSections;
  final List<WorkOut> listWorkOuts;

  SplashState({this.listSections, this.listWorkOuts});

}

class SplashStateInitial extends SplashState {}

class SplashStateLoading extends SplashState {}

class SplashStateLoaded extends SplashState {
  SplashStateLoaded({List<Section> listSections, List<WorkOut> listWorkOuts})
      : super(listSections: listSections, listWorkOuts: listWorkOuts);
}
