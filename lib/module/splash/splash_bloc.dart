import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/repo/workout_repo.dart';
import 'package:women_fitness_flutter/module/splash/splash_events.dart';
import 'package:women_fitness_flutter/module/splash/splash_states.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final WorkOutRepo _workOutRepo;

  SplashBloc({@required WorkOutRepo workOutRepo})
      : _workOutRepo = workOutRepo,
        super(SplashStateInitial());

  @override
  Stream<SplashState> mapEventToState(SplashEvent splashEvent) async* {
    switch (splashEvent.runtimeType) {
      case SplashGetDataEvent:
        yield* _mapEventGetData(splashEvent);
        break;
    }
  }

  Stream<SplashState> _mapEventGetData(SplashGetDataEvent event) async* {
    try {
      if (event.first) {
        yield SplashStateLoading();
      }

      final dataMainWorkOut = await _workOutRepo.getDataMainWorkOut();
      final dataMainSection = await _workOutRepo.getDataMainSection();
      yield SplashStateLoaded(
        listSections: dataMainSection,
        listWorkOuts: dataMainWorkOut,
      );
    } catch (e) {
      print('Loi workout_home $e');
    }
  }
}
