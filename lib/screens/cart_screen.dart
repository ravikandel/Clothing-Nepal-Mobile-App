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
            //final totalItems = cartManager.totalItems;
            final totalPrice = cartManager.totalPrice;

            return cart.isEmpty
                ? const Center(child: Text('Your cart is empty.'))
                : Stack(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.only(
                            bottom: 140), // Adjust for button height
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final product = cart[index]['product'];
                          final productSize = cart[index]['product_size'];
                          final productQuantity =
                              cart[index]['product_quantity'];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                    product: product,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.productName,
                                          style: const TextStyle(
                                              fontSize: 19,
                                              color: Color(0xFF004D67),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            if (product.discountPrice >
                                                0.0) ...[
                                              Text(
                                                '\$${product.discountPrice.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  color: Color(0xFF204E2D),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              if (product.actualPrice > 0.0)
                                                const SizedBox(width: 4),
                                            ],
                                            if (product.actualPrice > 0.0)
                                              Text(
                                                '\$${product.actualPrice.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.red,
                                                  decorationColor: Colors.red,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            const SizedBox(width: 10),
                                            Text(
                                              '|  Size: $productSize',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            // Minus Button
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF004D67),
                                                shape: BoxShape.circle,
                                              ),
                                              width: 40,
                                              height: 40,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 25,
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                iconSize: 20.0,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              width: 50,
                                              height: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .white, // Background color
                                                border: Border.all(
                                                  color: const Color(
                                                      0xFFD9D9D9), // Border color
                                                  width: 1.0, // Border width
                                                ),
                                                borderRadius: BorderRadius.circular(
                                                    10.0), // Rounded corners for the border
                                              ),
                                              child: Text(
                                                productQuantity.toString(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF004D67),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // Plus Button
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF204E2D),
                                                shape: BoxShape.circle,
                                              ),
                                              width: 40,
                                              height: 40,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 25,
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                iconSize: 20.0,
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
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors
                                                          .white, // Text color
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Background color for Delete button
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Subtotal Section
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: const Color(
                                        0xFFD9D9D9), // Adjust border color as needed
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sub Total',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF004D67),
                                      ),
                                    ),
                                    Text(
                                      '\$${totalPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF004D67),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      10), // Space between subtotal and button
                              // Proceed to Checkout Button
                              SizedBox(
                                width: double.infinity, // Full-width button
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to the next page
                                    Navigator.pushNamed(context, '/checkout');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    backgroundColor: const Color(0xFF004D67),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Proceed to Checkout →',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
