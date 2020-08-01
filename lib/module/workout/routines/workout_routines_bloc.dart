import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/module/training/training_bloc.dart';
import 'package:women_fitness_flutter/module/training/training_events.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_events.dart';
import 'package:women_fitness_flutter/module/workout/routines/workout_routines_states.dart';

class WorkOutRoutinesBloc
    extends Bloc<WorkOutRoutinesEvent, WorkOutRoutinesState> {
  TrainingBloc _trainingBloc;

  WorkOutRoutinesBloc({@required TrainingBloc trainingBloc})
      : _trainingBloc = trainingBloc,
        super(WorkOutRoutinesStateInitial());

  @override
  Stream<WorkOutRoutinesState> mapEventToState(
      WorkOutRoutinesEvent workOutRoutinesEvent) async* {
    switch (workOutRoutinesEvent.runtimeType) {
      case WorkOutRoutinesLikeEvent:
        yield* _mapLikeEvent(workOutRoutinesEvent);
        break;
      case WorkOutRoutinesUnLikeEvent:
        yield* _mapUnLikeEvent(workOutRoutinesEvent);
        break;
      case WorkOutRoutinesRefreshListEvent:
        yield* _mapRefreshListEvent(workOutRoutinesEvent);
        break;
    }
  }

  Stream<WorkOutRoutinesState> _mapLikeEvent(
      WorkOutRoutinesLikeEvent event) async* {
    _trainingBloc.add(TrainingLikeEvent(section: event.section));
    SPref.instance.setBool(event.section.title, true);
  }

  Stream<WorkOutRoutinesState> _mapUnLikeEvent(
      WorkOutRoutinesUnLikeEvent event) async* {
    _trainingBloc.add(TrainingUnLikeEvent(section: event.section));
    SPref.instance.setBool(event.section.title, false);
  }

  Stream<WorkOutRoutinesState> _mapRefreshListEvent(
      WorkOutRoutinesRefreshListEvent event) async* {
    _trainingBloc.add(TrainingUnLikeEvent(section: event.section));
    SPref.instance.setBool(event.section.title, false);
    yield WorkOutRoutinesStateRefresh();
  }
}
