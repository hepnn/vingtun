import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

import 'Round.dart';

class DbSQLite {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'historic.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE historic(id DOUBLE PRIMARY KEY, state INT, playerPoints INT, dealerPoints INT, playerCards TEXT)");
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Round round) async {
    final db = await DbSQLite.database();

    await db.insert(
      'historic',
      round.roundToMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.ignore,
    );
    print("Teoricamente inseriu no DB...");
  }

  static Future<List<Round>> getData(String table) async {
    final db = await DbSQLite.database();

    final List<Map<String, dynamic>> maps = await db.query('historic');

    return List.generate(maps.length, (i) {
      return Round(
        id: maps[i]['id'],
        state: maps[i]['state'],
        playerPoints: maps[i]['playerPoints'],
        dealerPoints: maps[i]['dealerPoints'],
        playerCards: maps[i]['playerCards'],
      );
    });
  }

  static Future<Round?> getLastRound(String table) async {
    final db = await DbSQLite.database();

    final List<Map<String, dynamic>> maps = await db.query('historic');

    int i = maps.length - 1;
    if (maps.isEmpty) {
      return null;
    } else {
      return Round(
        id: maps[i]['id'],
        state: maps[i]['state'],
        playerPoints: maps[i]['playerPoints'],
        dealerPoints: maps[i]['dealerPoints'],
        playerCards: maps[i]['playerCards'],
      );
    }
  }

  static Future<void> deleteData(String table) async {
    final db = await DbSQLite.database();

    await db.execute("DELETE FROM $table");
    print("Deveria ter ido...");
  }
}
