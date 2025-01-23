import 'package:demo/screens/cart_screen.dart';
import 'package:demo/screens/wishlist_screen.dart';
import 'package:demo/utils/cart_manager.dart';
import 'package:demo/utils/wishlist_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    WishlistScreen(), // Index 2
    CartScreen(), // Index 3
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
    final cartItemCount = context.watch<CartManager>().totalItems;
    final wishlistItemCount = context.watch<WishlistManager>().totalItems;
    return Scaffold(
      // Use IndexedStack for dynamic content change
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.favorite_rounded),
                if (wishlistItemCount > 0)
                  Positioned(
                    left: 15,
                    bottom: 10,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '$wishlistItemCount',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_rounded),
                if (cartItemCount > 0)
                  Positioned(
                    left: 15,
                    bottom: 10,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '$cartItemCount',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
        selectedItemColor: Color(0xFF204E2D),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
