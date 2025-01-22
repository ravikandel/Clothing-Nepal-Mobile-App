import 'package:demo/screens/product_screen.dart'; // Import ProductScreen
import 'package:demo/utils/snackbar_lib.dart';
import 'package:demo/utils/wishlist_manager.dart';
import 'package:demo/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  WishlistScreenState createState() => WishlistScreenState();
}

class WishlistScreenState extends State<WishlistScreen> {
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      UIUtils.showSnackbar(context, 'Page Refreshed!', Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: CustomAppBar(title: 'My Wishlist'),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer<WishlistManager>(
          builder: (context, wishlistManager, child) {
            final wishlist = wishlistManager.wishlist;

            return wishlist.isEmpty
                ? const Center(child: Text('Your wishlist is empty.'))
                : ListView.builder(
                    itemCount: wishlist.length,
                    itemBuilder: (context, index) {
                      final product = wishlist[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to ProductScreen on tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                product:
                                    product, // Pass product data to ProductScreen
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Color(0xFFD9D9D9), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  product.productImages[0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF004D67),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (product.discountPrice > 0.0) ...[
                                          Text(
                                            '\$${product.discountPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: Color(0xFF204E2D),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (product.actualPrice > 0.0)
                                            SizedBox(width: 4),
                                        ],
                                        if (product.actualPrice > 0.0)
                                          Text(
                                            '\$${product.actualPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.red,
                                              decorationColor: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Availability: In Stock',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF204E2D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                  color: Colors.red, // Background color
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.delete_forever,
                                      size: 40, color: Colors.white),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30.0, horizontal: 10),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: const Text(
                                            'Confirm Delete ?',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF004D67),
                                            ),
                                          ),
                                          content: Text(
                                            'Are you sure you want to delete ${product.productName} from your wishlist?',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF004D67),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: Color(
                                                    0xFF004D67), // Background color for Cancel button
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0), // Rounded corners
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors
                                                      .white, // Text color
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors
                                                    .red, // Background color for Delete button
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0), // Rounded corners
                                                ),
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<WishlistManager>()
                                                    .removeFromWishlist(
                                                        product);
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                                UIUtils.showSnackbar(
                                                  context,
                                                  '${product.productName} removed from wishlist!',
                                                  Colors.green,
                                                );
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors
                                                      .white, // Text color
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
