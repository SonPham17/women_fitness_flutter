import 'package:hive/hive.dart';

part 'challenge_week.g.dart';

@HiveType(typeId: 0)
class ChallengeWeek extends HiveObject {
  @HiveField(0)
  int idSection;

  @HiveField(1)
  String title;

  @HiveField(2)
  int index;

  ChallengeWeek({
    this.idSection,
    this.title,
    this.index
  });
}
