import 'package:hive/hive.dart';

part 'iap_fitness.g.dart';

@HiveType(typeId: 3)
class IAPFitness extends HiveObject{
  @HiveField(0)
  String idIAP;

  @HiveField(1)
  bool isBuy;

  IAPFitness({this.idIAP, this.isBuy});
}