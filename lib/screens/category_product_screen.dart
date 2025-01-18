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
  List<Product> _allProducts = []; // To hold all products
  List<Product> _filteredProducts = []; // For search/filter
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "lh";

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _searchController.addListener(_applyFilters);
  }

  Future<void> _fetchProducts() async {
    _productsFuture =
        ProductService().getFilteredProducts(categoryId: widget.categoryId);
    _productsFuture.then((products) {
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
      });
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    await _fetchProducts();
    if (mounted) {
      UIUtils.showSnackbar(context, 'Page Refreshed!', Colors.green);
    }
  }

  void _applyFilters() {
    String query = _searchController.text.toLowerCase();
    List<Product> filtered = _allProducts.where((product) {
      return product.productName.toLowerCase().contains(query);
    }).toList();

    if (_selectedFilter.toLowerCase() == "lh") {
      filtered.sort((a, b) => a.discountPrice.compareTo(b.discountPrice));
    } else if (_selectedFilter.toLowerCase() == "hl") {
      filtered.sort((a, b) => b.discountPrice.compareTo(a.discountPrice));
    }

    setState(() {
      _filteredProducts = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: CustomAppBar1(title: widget.categoryName),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: Column(
            children: [
              // Search and Filter Row
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Aligns children with space between
                  children: [
                    // Search Field
                    SizedBox(
                      height: 40.0, // Set desired height for the search bar
                      width: MediaQuery.of(context).size.width /
                          2.2, // Half the screen width
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFD9D9D9), // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search...",
                            suffixIcon: const Icon(Icons.search),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 5.0), // Adjust padding
                            border: InputBorder
                                .none, // Remove the default border inside
                            fillColor: Colors.white, // Light grey background
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),

                    // Filter Dropdown
                    Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width /
                          2.2, // Half the screen width
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // Background color for the dropdown
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                        border: Border.all(
                          color: Color(0xFFD9D9D9), // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        icon: const Icon(
                          Icons.filter_list,
                          color: Color(0xFF004D67),
                        ),
                        underline: const SizedBox(), // Remove default underline
                        items: const [
                          DropdownMenuItem(
                            value: "lh",
                            child: Text("Price (low - high)"),
                          ),
                          DropdownMenuItem(
                            value: "hl",
                            child: Text("Price (high - low)"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedFilter = value!;
                            _applyFilters();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
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

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 20,
                              childAspectRatio: 2.6 / 3,
                            ),
                            itemCount: _filteredProducts.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ProductCard(
                                  product: _filteredProducts[index],
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
