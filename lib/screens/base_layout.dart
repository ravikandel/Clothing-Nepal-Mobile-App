import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'categories_screen.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  int _selectedIndex = 0;

  // List of widgets for the different pages
  final List<Widget> _screens = [
    HomeScreen(), // Index 0
    CategoriesScreen(), // Index 1
    // FavoritesScreen(), // Index 2
    // CartScreen(), // Index 3
    // ProfileScreen(), // Index 4
  ];

  // Handle navigation bar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use IndexedStack for dynamic content change
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
        selectedItemColor: Color(0xFF204E2D),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
