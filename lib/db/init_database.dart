import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class InitDataBase {
  static Future<Database> database() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'list_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE uri(id INTEGER PRIMARY KEY,uri TEXT)",
        );
      },
      version: 1,
    );
  }
}
