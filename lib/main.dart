import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_ichiran/db/select.dart';
import 'navigator/bottom_nav_bar.dart';
import './db/model/list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavigator(),
    );
  }
}

final itemProvider = FutureProvider<List<Item>>((ref) async {
  return await getLists();
});
