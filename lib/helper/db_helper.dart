import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
   DBHelper._();

   static DBHelper dbHelper = DBHelper._();

  Database? db;

   Future<void> initDB() async {
    String dbPath = await getDatabasesPath();

    String path = "${dbPath}budget.db";

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        String query = '''CREATE TABLE category(
            category_id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_name TEXT NOT NULL,
            category_image BLOB NOT NULL
        );''';

        await db.execute(query).then(
              (value) {
            print("Student table created");
          },
        ).onError(
              (error, _) {
                print("Student table not creation");
           },
        );
      },
    );
  }

   Future<int?> insertCategory({
    required String name,
    required Uint8List image,
  }) async {
    await initDB();
    String query =
        "INSERT INTO category (category_name, category_image) VALUES(?, ?);";

    List data = [name, image];

    return await db?.rawInsert(query, data);
  }
}