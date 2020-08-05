import 'package:flutter/cupertino.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

abstract class FavoriteTrainingState {}

class FavoriteTrainingStateInitial extends FavoriteTrainingState {}

class FavoriteTrainingStateGetWorkOutBySectionDone
    extends FavoriteTrainingState {
  final List<WorkOut> listWorkOutBySection;

  FavoriteTrainingStateGetWorkOutBySectionDone(
      {@required this.listWorkOutBySection});
}

class FavoriteTrainingStateResetWorkOut extends FavoriteTrainingState{
  WorkOut workOut;

  FavoriteTrainingStateResetWorkOut({this.workOut});
}

class FavoriteTrainingStateEdit extends FavoriteTrainingState{

}

class FavoriteTrainingStateResetListDone extends FavoriteTrainingState{
  final List<WorkOut> listWorkOutReset;

  FavoriteTrainingStateResetListDone(
      {@required this.listWorkOutReset});
}
