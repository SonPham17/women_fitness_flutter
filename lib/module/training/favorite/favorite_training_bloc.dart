import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/data/repo/training_repo.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_events.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_states.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

class FavoriteTrainingBloc
    extends Bloc<FavoriteTrainingEvent, FavoriteTrainingState> {
  TrainingRepo _trainingRepo;

  FavoriteTrainingBloc({@required TrainingRepo trainingRepo})
      : _trainingRepo = trainingRepo,
        super(FavoriteTrainingStateInitial());

  @override
  Stream<FavoriteTrainingState> mapEventToState(
      FavoriteTrainingEvent favoriteTrainingEvent) async* {
    print(favoriteTrainingEvent.runtimeType);
    switch (favoriteTrainingEvent.runtimeType) {
      case FavoriteTrainingGetWorkOutBySectionEvent:
        var getWorkOutEvent =
            favoriteTrainingEvent as FavoriteTrainingGetWorkOutBySectionEvent;
        var list = await _trainingRepo.getListWorkOutBySection(
            getWorkOutEvent.listWorkOuts, getWorkOutEvent.section);
        yield FavoriteTrainingStateGetWorkOutBySectionDone(
            listWorkOutBySection: list);
        break;
      case FavoriteTrainingResetItemWorkOutEvent:
        var resetWorkOut =
            favoriteTrainingEvent as FavoriteTrainingResetItemWorkOutEvent;
        var workOutReset =
            await _trainingRepo.getWorkOutByReset(resetWorkOut.workOut);
        yield FavoriteTrainingStateResetWorkOut(workOut: workOutReset);
        break;
      case FavoriteTrainingResetListWorkOutEvent:
        var getResetList =
            favoriteTrainingEvent as FavoriteTrainingResetListWorkOutEvent;
        var list =
            await _trainingRepo.getListResetWorkOut(getResetList.section);
        yield FavoriteTrainingStateResetListDone(listWorkOutReset: list);
        break;
    }
  }
}
