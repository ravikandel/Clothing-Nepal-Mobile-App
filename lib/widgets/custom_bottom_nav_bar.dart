import 'package:demo/screens/base_layout.dart';
import 'package:demo/utils/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFAFAFA), // Fixed background color
      elevation: 0, // Remove shadow
      automaticallyImplyLeading: false, // No default back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Color(0xFF004D67)),
            iconSize: 30.0,
            onPressed: () {},
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF004D67),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_rounded,
                color: Color(0xFF004D67)),
            iconSize: 30.0,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 0.8);
}

class CustomAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar1({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Get the dynamic cart item count from CartManager
    final cartItemCount = context.watch<CartManager>().totalItems;

    return AppBar(
      backgroundColor: const Color(0xFFFAFAFA), // Fixed background color
      elevation: 0, // Remove shadow
      automaticallyImplyLeading: false, // No default back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon:
                const Icon(Icons.arrow_back_rounded, color: Color(0xFF004D67)),
            iconSize: 30.0,
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF004D67),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Cart and Share icons
          Row(
            children: [
              // Share icon
              IconButton(
                icon: const Icon(Icons.notifications_rounded,
                    color: Color(0xFF004D67)),
                iconSize: 30.0,
                onPressed: () {
                  // Handle share functionality
                },
              ),
              // Cart icon with badge
              Stack(
                clipBehavior: Clip.none, // Allow for badge overlap
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_rounded,
                        color: Color(0xFF004D67)),
                    iconSize: 30.0,
                    onPressed: () {
                      // Navigate to BaseLayout and set the selected index to 3 (Cart screen)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BaseLayout(selectedIndex: 3), // Pass the index
                        ),
                      );
                    },
                  ),
                  // Item count badge
                  if (cartItemCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 0.8);
}

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar2({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Get the dynamic cart item count from CartManager
    final cartItemCount = context.watch<CartManager>().totalItems;

    return AppBar(
      backgroundColor: const Color(0xFFFAFAFA), // Fixed background color
      elevation: 0, // Remove shadow
      automaticallyImplyLeading: false, // No default back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          IconButton(
            icon:
                const Icon(Icons.arrow_back_rounded, color: Color(0xFF004D67)),
            iconSize: 30.0,
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF004D67),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Cart and Share icons
          Row(
            children: [
              // Share icon
              IconButton(
                icon: const Icon(Icons.ios_share_rounded,
                    color: Color(0xFF004D67)),
                iconSize: 30.0,
                onPressed: () {
                  // Handle share functionality
                },
              ),
              // Cart icon with badge
              Stack(
                clipBehavior: Clip.none, // Allow for badge overlap
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_rounded,
                        color: Color(0xFF004D67)),
                    iconSize: 30.0,
                    onPressed: () {
                      // Navigate to BaseLayout and set the selected index to 3 (Cart screen)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BaseLayout(selectedIndex: 3), // Pass the index
                        ),
                      );
                    },
                  ),
                  // Item count badge
                  if (cartItemCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 0.8);
}

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  CustomBottomNavBarState createState() => CustomBottomNavBarState();
}

class CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Prevent unnecessary navigation

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/categories');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/cart');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded), label: 'Wishlist'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded), label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded), label: 'Profile'),
      ],
      selectedItemColor: Color(0xFF204E2D),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
