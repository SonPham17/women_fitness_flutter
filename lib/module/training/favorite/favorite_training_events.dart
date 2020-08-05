import 'package:flutter/cupertino.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

abstract class FavoriteTrainingEvent {}

class FavoriteTrainingGetWorkOutBySectionEvent extends FavoriteTrainingEvent {
  final Section section;
  final List<WorkOut> listWorkOuts;

  FavoriteTrainingGetWorkOutBySectionEvent(
      {@required this.section, @required this.listWorkOuts,});

}

class FavoriteTrainingResetListWorkOutEvent extends FavoriteTrainingEvent{
}

class FavoriteTrainingResetItemWorkOutEvent extends FavoriteTrainingEvent{
  final WorkOut workOut;

  FavoriteTrainingResetItemWorkOutEvent({this.workOut});
}

class FavoriteTrainingEditEvent extends FavoriteTrainingEvent{}