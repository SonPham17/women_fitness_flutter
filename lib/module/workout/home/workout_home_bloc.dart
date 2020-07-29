import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/repo/workout_repo.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_events.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_states.dart';

class WorkOutHomeBloc extends Bloc<WorkOutHomeEvent, WorkOutHomeState> {
  final WorkOutRepo _workOutRepo;

  WorkOutHomeBloc({@required WorkOutRepo workOutRepo})
      : _workOutRepo = workOutRepo,
        super(WorkOutHomeStateInitial());

  @override
  Stream<WorkOutHomeState> mapEventToState(
      WorkOutHomeEvent workOutHomeEvent) async* {
    switch (workOutHomeEvent.runtimeType) {
      case WorkOutHomeGetDataEvent:
        yield* _mapEventGetData(workOutHomeEvent);
        break;
    }
  }

  Stream<WorkOutHomeState> _mapEventGetData(
      WorkOutHomeGetDataEvent event) async* {
    try {
      if (event.first) {
        yield WorkOutHomeStateLoading();
      }

      final dataMainWorkOut = await _workOutRepo.getDataMainWorkOut();
      yield WorkOutHomeStateLoaded(listSections: dataMainWorkOut);
    } catch (e) {
      print('Loi workout_home $e');
    }
  }
}
