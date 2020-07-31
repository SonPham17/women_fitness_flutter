import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/repo/workout_repo.dart';
import 'package:women_fitness_flutter/data/spref/spref.dart';
import 'package:women_fitness_flutter/module/training/training_bloc.dart';
import 'package:women_fitness_flutter/module/training/training_events.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_events.dart';
import 'package:women_fitness_flutter/module/workout/home/workout_home_states.dart';

class WorkOutHomeBloc extends Bloc<WorkOutHomeEvent, WorkOutHomeState> {
  TrainingBloc _trainingBloc;

  WorkOutHomeBloc({@required TrainingBloc trainingBloc})
      : _trainingBloc = trainingBloc,
        super(WorkOutHomeStateInitial());

  @override
  Stream<WorkOutHomeState> mapEventToState(
      WorkOutHomeEvent workOutHomeEvent) async* {
    switch (workOutHomeEvent.runtimeType) {
      case WorkOutHomeLikeEvent:
        yield* _mapLikeEvent(workOutHomeEvent);
        break;
      case WorkOutHomeUnLikeEvent:
        yield* _mapUnLikeEvent(workOutHomeEvent);
        break;
    }
  }

  Stream<WorkOutHomeState> _mapLikeEvent(WorkOutHomeLikeEvent event) async* {
    _trainingBloc.add(TrainingLikeEvent(section: event.section));
    SPref.instance.setBool(event.section.title, true);
  }

  Stream<WorkOutHomeState> _mapUnLikeEvent(
      WorkOutHomeUnLikeEvent event) async* {
    SPref.instance.setBool(event.section.title, false);
  }
}
