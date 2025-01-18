import 'package:demo/utils/snackbar_lib.dart';
import 'package:flutter/material.dart';
import 'package:demo/widgets/banner_slider.dart';
import 'package:demo/widgets/custom_bottom_nav_bar.dart';
import 'package:demo/widgets/section_title.dart';
import 'package:demo/model/product_service.dart'; // Import the product service

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
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
        onRefresh: _refreshData,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          children: [
            BannerSlider(),
            SectionTitle(title: 'New Fashion', id: 2),
            ProductList(tagId: 2, count: 10),
            SectionTitle(title: 'Summer Sale', id: 4),
            ProductList(tagId: 4),
            SectionTitle(title: 'Top Picks', id: 1),
            ProductList(tagId: 1, count: 10),
            SectionTitle(title: 'Sale Under 20\$', id: 3),
            ProductList(tagId: 3),
            SectionTitle(title: 'Clearance Sale', id: 5),
            ProductList(tagId: 5),
          ],
        ),
      ),
      //bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}
