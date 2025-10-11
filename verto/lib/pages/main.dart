import 'package:flutter/material.dart';
import 'package:verto/pages/explore/explore.dart';
import 'home/home.dart'; 
import 'profile/profile.dart';
import 'package:advanced_salomon_bottom_bar/advanced_salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // This list now uses your HomePage for the first tab.
  static final List<Widget> _pages = <Widget>[
    const HomePage(), 
    const ExplorePage(),
    const Center(
      child: Text('Page 3: Messages', style: TextStyle(fontSize: 24)),
    ),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentIndex),
       bottomNavigationBar: AdvancedSalomonBottomBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            AdvancedSalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            AdvancedSalomonBottomBarItem(
              icon: Icon(Icons.favorite_border),
              title: Text("Explore"),
              selectedColor: Colors.orange,
            ),

            /// Search
            AdvancedSalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("Message"),
              selectedColor: Colors.pink,
            ),

            /// Profile
            AdvancedSalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
       ),
    );
  }
}