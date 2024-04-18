import 'dart:async';
import 'dart:math';
import 'package:petty_shop_vinit/model/dog_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _db;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static const String _dbName = 'dog_app.db';
  static const String _dogsTable = 'dogs'; // Single table for all dogs

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);
    final db = await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE $_dogsTable (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              message TEXT NOT NULL,
              price TEXT NOT NULL,
              in_cart INTEGER NOT NULL DEFAULT 0
            )
          ''');
    }, version: 1);
    return db;
  }

  Future<void> insertDog(String message) async {
    final db = await this.db;
    final data = {
      'message': message,
      'price': Random().nextInt(3000).toString(),
      'in_cart': 0
    };

    print("insertDog data is $data");
    await db.insert(_dogsTable, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    getDogs();
  }

  Future<List<Dog>> getDogs() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query(_dogsTable);
    return List.generate(maps.length, (i) => Dog.fromJson(maps[i]));
  }

  Future<void> updateDogInCart(int dogId, bool isInCart) async {
    final db = await this.db;
    await db.update(_dogsTable, {'in_cart': isInCart ? 1 : 0},
        where: 'id = ?', whereArgs: [dogId]);
  }

  Future<void> deleteDog(int dogId) async {
    final db = await this.db;
    await db.delete(_dogsTable, where: 'id = ?', whereArgs: [dogId]);
  }

  Future<void> clearHistory() async {
    final db = await this.db;
    await db.delete(_dogsTable);
  }
}
