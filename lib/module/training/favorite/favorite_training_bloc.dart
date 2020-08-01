import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/repo/training_repo.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_events.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_states.dart';

class FavoriteTrainingBloc
    extends Bloc<FavoriteTrainingEvent, FavoriteTrainingState> {
  TrainingRepo _trainingRepo;

  FavoriteTrainingBloc({@required TrainingRepo trainingRepo})
      : _trainingRepo = trainingRepo,
        super(FavoriteTrainingStateInitial());

  @override
  Stream<FavoriteTrainingState> mapEventToState(
      FavoriteTrainingEvent favoriteTrainingEvent) async* {
    switch (favoriteTrainingEvent.runtimeType) {
      case FavoriteTrainingGetWorkOutBySectionEvent:
        var getWorkOutEvent =
            favoriteTrainingEvent as FavoriteTrainingGetWorkOutBySectionEvent;
        var list = await _trainingRepo.getListWorkOutBySection(
            getWorkOutEvent.listWorkOuts, getWorkOutEvent.section);
        yield FavoriteTrainingStateGetWorkOutBySectionDone(
            listWorkOutBySection: list);
        break;
    }
  }
}
