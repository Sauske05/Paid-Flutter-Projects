import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBhelper {
  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final dbpath = await sql.getDatabasesPath();
    final sqlDb = await sql.openDatabase(path.join(dbpath, 'places.db'),
        onCreate: ((db, version) {
      return db.execute(
          'CREATE TABLE Test (id TEXT PRIMARY KEY, title TEXT, image TEXT,)');
    }), version: 1);
    await sqlDb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
}
