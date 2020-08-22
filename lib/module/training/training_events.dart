import 'package:flutter/cupertino.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';

abstract class TrainingEvent  {
}

class TrainingLikeEvent extends TrainingEvent {
  final Section section;

  TrainingLikeEvent({@required this.section});
}

class TrainingUnLikeEvent extends TrainingEvent {
  final Section section;

  TrainingUnLikeEvent({@required this.section});
}

class TrainingGetSectionFavoriteEvent extends TrainingEvent {
  final List<Section> listSections;

  TrainingGetSectionFavoriteEvent({@required this.listSections});
}
