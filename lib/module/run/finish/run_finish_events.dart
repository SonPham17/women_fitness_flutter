import 'package:flutter/cupertino.dart';

abstract class RunFinishEvent{}

class RunFinishRefreshEvent extends RunFinishEvent{
  double height;
  double weight;

  RunFinishRefreshEvent({@required this.height,@required this.weight});
}