import 'package:demo/model/category_service.dart';
import 'package:demo/utils/snackbar_lib.dart';
import 'package:flutter/material.dart';
import 'package:demo/widgets/custom_bottom_nav_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  Future<void> _refreshData() async {
    // Simulate a network request or refresh action here
    await Future.delayed(Duration(seconds: 2));

    // Check if the widget is still mounted before showing the snackbar
    if (mounted) {
      UIUtils.showSnackbar(context, 'Page Refreshed!', Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomAppBar(title: 'Clothing Nepal'),
      body: RefreshIndicator(
        onRefresh: _refreshData, // Call the refresh function on swipe down
        child: ListView(
          children: [CategoryList()],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
    );
  }
}
