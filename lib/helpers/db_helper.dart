import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'todoey.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE user_todos(id TEXT PRIMARY KEY, name TEXT, is_done BOOLEAN)",
      );
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.database();
    final count = await db.rawDelete("DELETE FROM $table WHERE id = '$id'");
    assert(count == 1);
  }

  static Future<void> update(String table, String id, bool isDone) async {
    final db = await DBHelper.database();
    final count = await db.rawUpdate(
        "UPDATE $table SET is_done = ${isDone == true ? 1 : 0} WHERE id = '$id'");
    assert(count == 1);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
