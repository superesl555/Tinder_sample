import 'package:flutter/material.dart';
import 'screens/cat_swipe_screen.dart';
import 'screens/breeds_list_screen.dart';

class RootTabsScreen extends StatefulWidget {
  const RootTabsScreen({super.key});

  @override
  State<RootTabsScreen> createState() => _RootTabsScreenState();
}

class _RootTabsScreenState extends State<RootTabsScreen> {
  int _currentIndex = 0;

  final _pages = const [
    CatSwipeScreen(),
    BreedsListScreen(),
  ];

  Widget _buildTitle(BuildContext context) {
    if (_currentIndex == 0) {
      final screenWidth = MediaQuery.of(context).size.width;

      return Align(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'lib/img/logo_3.png',
          height: screenWidth * 0.4,
          width: screenWidth * 0.4,
        ),
      );
    } else {
      return const Text('Список пород');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(context),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Котики',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Породы',
          ),
        ],
      ),
    );
  }
}
