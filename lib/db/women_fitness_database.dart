import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WomenFitnessDatabase {
  static Database _database;

  WomenFitnessDatabase._internal();

  static final WomenFitnessDatabase instance = WomenFitnessDatabase._internal();

  Database get database => _database;

  init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "WorkOut.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      // print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "WorkOut.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    _database = await openDatabase(path, readOnly: true);
  }
}
