import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_ichiran/view/home_page.dart';
import 'package:qr_ichiran/view/list_page.dart';

class BottomNavigator extends ConsumerStatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigator createState() => _BottomNavigator();
}

class _BottomNavigator extends ConsumerState<BottomNavigator> {
  int _currentIndex = 0;
  final _pageWidgets = [
    const HomePage(),
    ListPage(),
  ];

  void _onItemTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        body: _pageWidgets.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_outlined),
              label: 'ホーム',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notes),
              activeIcon: Icon(Icons.notes_outlined),
              label: '履歴',
              backgroundColor: Colors.green,
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: _currentIndex,
        ),
      ),
    );
  }
}
