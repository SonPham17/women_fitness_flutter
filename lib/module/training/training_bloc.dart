import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/repo/training_repo.dart';
import 'package:women_fitness_flutter/module/training/training_events.dart';
import 'package:women_fitness_flutter/module/training/training_states.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  TrainingRepo _trainingRepo;

  TrainingBloc({@required TrainingRepo trainingRepo})
      : _trainingRepo = trainingRepo,
        super(TrainingStateInitial());

  @override
  Stream<TrainingState> mapEventToState(TrainingEvent trainingEvent) async* {
    switch (trainingEvent.runtimeType) {
      case TrainingLikeEvent:
        print('like event');
        break;
      case TrainingGetSectionFavoriteEvent:
        var eventFavorite = trainingEvent as TrainingGetSectionFavoriteEvent;
        var listFavorites = await _trainingRepo
            .getListSectionFavorite(eventFavorite.listSections);
        yield TrainingStateGetFavoriteDone(lists: listFavorites);
        break;
    }
  }
}
