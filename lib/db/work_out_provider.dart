import 'package:sqflite/sqflite.dart';
import 'package:women_fitness_flutter/db/women_fitness_database.dart';
import 'package:women_fitness_flutter/shared/model/challenge.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';

class WorkOutProvider {
  Future<List<Challenge>> getAllChallenge() async {
    final Database db = WomenFitnessDatabase.instance.database;

    final List<Map<String, dynamic>> maps = await db.query('challenge');

    return maps.map((challenge) => Challenge.fromData(challenge)).toList();
  }

  Future<List<Section>> getAllSection() async {
    final Database db = WomenFitnessDatabase.instance.database;

    final List<Map<String, dynamic>> maps = await db.query('section');

    return maps.map((section) => Section.fromData(section)).toList();
  }

  Future<List<WorkOut>> getAllWorkOut() async {
    final Database db = WomenFitnessDatabase.instance.database;

    final List<Map<String, dynamic>> maps = await db.query('workout');

    return maps.map((workout) => WorkOut.fromData(workout)).toList();
  }

  Future<WorkOut> getWorkOutByReset(int id) async {
    final Database db = WomenFitnessDatabase.instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM workout WHERE id=?',[id]);
    return WorkOut.fromData(maps[0]);
  }
}
