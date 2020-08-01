
import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class WorkOutRoutinesEvent{

}

class WorkOutRoutinesLikeEvent extends WorkOutRoutinesEvent{
  final Section section;

  WorkOutRoutinesLikeEvent({this.section});
}

class WorkOutRoutinesUnLikeEvent extends WorkOutRoutinesEvent{
  final Section section;

  WorkOutRoutinesUnLikeEvent({this.section});
}

class WorkOutRoutinesRefreshListEvent extends WorkOutRoutinesEvent{
  final Section section;

  WorkOutRoutinesRefreshListEvent({this.section});
}