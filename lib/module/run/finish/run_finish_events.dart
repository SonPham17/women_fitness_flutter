import 'package:flutter/cupertino.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

abstract class RunFinishEvent{}

class RunFinishRefreshEvent extends RunFinishEvent{
  double height;
  double weight;

  RunFinishRefreshEvent({@required this.height,@required this.weight});
}

class RunFinishGetAllSectionEvent extends RunFinishEvent{
  List<WorkOut> listWorkOuts;

  RunFinishGetAllSectionEvent({this.listWorkOuts});
}