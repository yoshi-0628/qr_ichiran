import 'package:sqflite/sqflite.dart';
import './model/list.dart';
import 'init_database.dart';

Future<List<Item>> getLists() async {
  final Database db = await InitDataBase.database();
  final List<Map<String, dynamic>> tmpMaps =
      await db.query('uri', orderBy: 'id');
  final List<Map<String, dynamic>> maps = tmpMaps.reversed.toList();
  return List.generate(maps.length, (i) {
    return Item(
      uri: maps[i]['uri'],
    );
  });
}
