import 'package:budget_tracker/modal/category_modal.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  Database? db;

  String categoryTable = "category";
  String categoryName = "category_name";
  String categoryImage = "category_image";

  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();

    String path = "${dbPath}budget.db";

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        String query = '''CREATE TABLE $categoryTable(
            category_id INTEGER PRIMARY KEY AUTOINCREMENT,
            $categoryName TEXT NOT NULL,
            $categoryImage BLOB NOT NULL
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

  Future<int?> insertCategory(
      {required String name, required Uint8List image}) async {
    await initDB();
    String query =
        "INSERT INTO $categoryTable ($categoryName, $categoryImage) VALUES(?, ?);";

    List data = [name, image];

    return await db?.rawInsert(query, data);
  }

  // Show Data

  Future<List<CategoryModel>> fetchData() async {
    await initDB();

    String query = "SELECT * FROM $categoryTable;";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => CategoryModel.fromMap(data: e),
        )
        .toList();
  }

  // Search Query
  Future<List<CategoryModel>> liveSearchCategory({
    required String search,
  }) async {
    await initDB();
    String query =
        "SELECT * FROM $categoryTable WHERE $categoryName LIKE '%$search%';";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => CategoryModel.fromMap(data: e),
    )
        .toList();
  }

}
