// This file which will have all the functionality to interact with a database.

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql
        .getDatabasesPath(); // This is the path where you store your database.
    // it yeilds a string which is a path.
    // dbPath is a folder of the database.
    return sql.openDatabase(path.join(dbPath, "places.db"),
        // onCreate function will execute when sqlite tries to open a database and
        // does'nt find the file so then it will create a new file.
        // version means open the file with that version.
        onCreate: (db, version) {
      return db.execute(
          // image is of type TEXT because we want to store path in the database.
          "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)"); // this query will run against our database.
      // we should return this so sqflite knows when this is done.
    }, version: 1); // join is use to create a new
    // path made up of the db path.
  }

  // This class simply acts as a group around all these methods.
  // This is a good approach.
  static Future<void> insert(String table, Map<String, Object> data) async {
    // Database operation can take a bit longer so it is assynchronus.

    // ConflictAlgorithm.replace it means if we are trying to add the data
    // for the id which already exists then we replace the new id with
    // the old id.
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    // the table is the table from which we can fetch the data.
    final db = await DBHelper.database();
    return db.query(table);
  }
}