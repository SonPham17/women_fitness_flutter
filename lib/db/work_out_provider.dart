import 'package:sqflite/sqflite.dart';
import 'package:women_fitness_flutter/db/women_fitness_database.dart';
import 'package:women_fitness_flutter/shared/model/challenge.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';

class WorkOutProvider {
  Future<List<Challenge>> getAllChallenge() async {
    final Database db = WomenFitnessDatabase.instance.database;

    final List<Map<String, dynamic>> maps = await db.query('challenge');

    return maps.map((challenge) => Challenge.fromData(challenge)).toList();
  }

  Future<List<Section>> getAllSection() async{
    final Database db= WomenFitnessDatabase.instance.database;

    final List<Map<String,dynamic>> maps = await db.query('section');

    return maps.map((section) => Section.fromData(section)).toList();
  }
}
