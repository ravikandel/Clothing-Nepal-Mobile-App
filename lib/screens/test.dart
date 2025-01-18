import 'package:demo/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:demo/model/product_service.dart'; // Product fetching logic
import 'package:demo/utils/snackbar_lib.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  CategoryProductsScreenState createState() => CategoryProductsScreenState();
}

class CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture =
        ProductService().getFilteredProducts(categoryId: widget.categoryId);
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _productsFuture =
          ProductService().getFilteredProducts(categoryId: widget.categoryId);
    });
    if (mounted) {
      UIUtils.showSnackbar(context, 'Page Refreshed!', Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: CustomAppBar1(title: widget.categoryName),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products found.'));
              }

              List<Product> products = snapshot.data!;

              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Flexible child for GridView to avoid overflow
                    GridView.builder(
                      shrinkWrap:
                          true, // Prevent GridView from taking infinite height
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 20,
                        childAspectRatio: 2.6 / 3,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ProductCard(
                            product: products[index],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
