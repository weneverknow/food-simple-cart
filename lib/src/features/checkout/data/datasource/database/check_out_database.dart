import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../../../../../core/database/database_service.dart';

class CheckOutDatabase {
  static Future<void> createTable() async {
    final database = await DatabaseService.initDb();
    final isExist = await database
        .query('sqlite_master', where: 'name = ?', whereArgs: ["checkout"]);

    if (isExist.isEmpty) {
      await database.execute(
          "CREATE TABLE checkout (id INTEGER PRIMARY KEY AUTOINCREMENT, restaurant_id INTEGER, product_id INTEGER, qty INTEGER, total REAL, notes TEXT, table_no TEXT, created_date INTEGER)");
    }
  }

  static Future<int> insert(List<Map<String, dynamic>> bodies) async {
    try {
      final database = await DatabaseService.initDb();
      bodies.forEach((element) async {
        await database.insert('checkout', element);
      });

      return 1;
    } catch (e) {
      print("err $e");
      throw Exception(e);
    }
  }

  static Future<List<Map<String, dynamic>>?> get() async {
    final database = await DatabaseService.initDb();
    final items =
        await database.rawQuery("SELECT * FROM checkout ORDER BY id DESC");

    return items;
  }
}
