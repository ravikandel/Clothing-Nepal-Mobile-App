import 'package:demo/screens/product_screen.dart'; // Import ProductScreen
import 'package:demo/utils/snackbar_lib.dart';
import 'package:demo/utils/cart_manager.dart';
import 'package:demo/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
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
      appBar: CustomAppBar(title: 'My Cart'),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer<CartManager>(
          builder: (context, cartManager, child) {
            final cart = cartManager.cartItems;

            return cart.isEmpty
                ? const Center(child: Text('Your cart is empty.'))
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product =
                          cart[index]['product']; // Accessing product correctly
                      final productSize = cart[index]['product_size'];
                      final productQuantity = cart[index]['product_quantity'];

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
                            border: Border.all(
                                color: const Color(0xFFD9D9D9), width: 1),
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
                                            style: const TextStyle(
                                              color: Color(0xFF204E2D),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (product.actualPrice > 0.0)
                                            const SizedBox(width: 4),
                                        ],
                                        if (product.actualPrice > 0.0)
                                          Text(
                                            '\$${product.actualPrice.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.red,
                                              decorationColor: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '|  Size: $productSize',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF204E2D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // plus buttons
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        // Minus Button
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(
                                                0xFF004D67), // Button background color
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.remove, // Icon design
                                              color: Colors.white, // Icon color
                                            ),
                                            onPressed: () {
                                              if (productQuantity > 1) {
                                                context
                                                    .read<CartManager>()
                                                    .updateQuantity(
                                                      product,
                                                      productSize,
                                                      productQuantity - 1,
                                                    );
                                              }
                                            },
                                            padding: const EdgeInsets.all(8.0),
                                            iconSize: 20.0, // Icon size
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                8), // Space between the buttons and quantity
                                        // Quantity Text with fixed width
                                        Container(
                                          width: 40,
                                          height:
                                              40, // Fixed width for quantity
                                          alignment: Alignment.center,
                                          color: Colors.white,
                                          child: Text(
                                            productQuantity.toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF004D67),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                8), // Space between the buttons and quantity
                                        // Plus Button
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(
                                                0xFF204E2D), // Button background color
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.add, // Icon design
                                              color: Colors.white, // Icon color
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<CartManager>()
                                                  .updateQuantity(
                                                    product,
                                                    productSize,
                                                    productQuantity + 1,
                                                  );
                                            },
                                            padding: const EdgeInsets.all(8.0),
                                            iconSize: 20.0, // Icon size
                                          ),
                                        ),
                                      ],
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
                                  padding: const EdgeInsets.symmetric(
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
                                            'Are you sure you want to delete ${product.productName} from your cart?',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF004D67),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: const Color(
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
                                                    .read<CartManager>()
                                                    .removeFromCart(product,
                                                        size:
                                                            productSize); // Delete based on size
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                                UIUtils.showSnackbar(
                                                  context,
                                                  '${product.productName} removed from cart!',
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
