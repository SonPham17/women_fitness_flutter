import 'package:hive/hive.dart';

part 'section_history.g.dart';

@HiveType(typeId: 1)
class SectionHistory extends HiveObject {
  @HiveField(0)
  int totalTime;

  @HiveField(1)
  int sectionId;

  @HiveField(2)
  double calories;

  @HiveField(3)
  String day;

  @HiveField(4)
  String timeFinish;

  @HiveField(5)
  String thumb;

  SectionHistory({
    this.totalTime,
    this.sectionId,
    this.calories,
    this.day,
    this.timeFinish,
    this.thumb,
  });
}
