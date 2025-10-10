import 'package:flutter/material.dart';
import 'package:verto/pages/explore/explore.dart';
import 'home/home.dart'; // ✅ 1. Import your home.dart file

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // This list now uses your HomePage for the first tab.
  static final List<Widget> _pages = <Widget>[
    const HomePage(), 
    const ExplorePage(),
    const Center(
      child: Text('Page 3: Favorites', style: TextStyle(fontSize: 24)),
    ),
    const Center(
      child: Text('Page 4: Settings', style: TextStyle(fontSize: 24)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar is removed from here because your HomePage likely has its own.
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}