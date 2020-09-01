import 'package:hive/hive.dart';

part 'admob_fitness.g.dart';

@HiveType(typeId: 2)
class AdmobFitness extends HiveObject{
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isLoaded;

  AdmobFitness({this.title, this.isLoaded});
}