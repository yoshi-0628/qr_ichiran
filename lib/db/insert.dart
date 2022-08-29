import 'package:sqflite/sqflite.dart';
import './model/list.dart';
import 'init_database.dart';

Future<void> insertList(Item item) async {
  final Database db = await InitDataBase.database();
  await db.insert(
    'uri',
    item.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
