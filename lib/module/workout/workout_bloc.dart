import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/repo/workout_repo.dart';
import 'package:women_fitness_flutter/module/workout/workout_events.dart';
import 'package:women_fitness_flutter/module/workout/workout_states.dart';

class WorkOutBloc extends Bloc<WorkOutEvent, WorkOutState> {
  final WorkOutRepo _workOutRepo;

  WorkOutBloc({@required WorkOutRepo workOutRepo})
      : _workOutRepo = workOutRepo,
        super(WorkOutStateInitial());

  @override
  Stream<WorkOutState> mapEventToState(WorkOutEvent workOutEvent) async* {
    switch (workOutEvent.runtimeType) {
      case WorkOutGetDataEvent:
        yield* _mapEventGetData(workOutEvent);
        break;
    }
  }

  Stream<WorkOutState> _mapEventGetData(WorkOutGetDataEvent event) async* {
    try {
      if (event.first) {
        yield WorkOutStateLoading();
      }

      final dataMainWorkOut = await _workOutRepo.getDataMainSection();
      yield WorkOutStateLoaded(listSections: dataMainWorkOut);
    } catch (e) {
      print('Loi workout_home $e');
    }
  }
}
