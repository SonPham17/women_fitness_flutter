import 'package:hive/hive.dart';

part 'challenge_week.g.dart';

@HiveType(typeId: 0)
class ChallengeWeek {
  @HiveField(0)
  int idSection;

  @HiveField(1)
  String title;

  ChallengeWeek({this.idSection, this.title});
}
