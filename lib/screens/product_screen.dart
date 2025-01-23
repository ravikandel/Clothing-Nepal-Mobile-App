import 'package:demo/model/product_service.dart';
import 'package:demo/utils/snackbar_lib.dart';
import 'package:demo/utils/wishlist_manager.dart';
import 'package:demo/utils/cart_manager.dart';
import 'package:demo/widgets/custom_bottom_nav_bar.dart';
import 'package:demo/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  String? selectedSize;
  int _currentIndex = 0; // Track the current slider index
  int quantity = 1; // Quantity of the product

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: CustomAppBar2(title: "Clothing Nepal"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Carousel with padding
                  CarouselSlider(
                    items: widget.product.productImages.map((image) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0), // Add padding here
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.5,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index; // Update the current index
                        });
                      },
                    ),
                  ),
                  // Dot indicator for carousel
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.product.productImages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 8.0,
                          width: 8.0,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? Color(0xFF004D67)
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Product Details
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.product.productName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF004D67),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Product Code: ${widget.product.productCode}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF204E2D),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                i < widget.product.rating
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: const Color(0xFFF27922),
                                size: 30,
                              ),
                            const SizedBox(width: 8),
                            Text(
                              '(${widget.product.reviewCount} Reviews)',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\$${widget.product.discountPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF204E2D),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (widget.product.actualPrice > 0)
                              Text(
                                '\$${widget.product.actualPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor:
                                      Colors.red, // Set the line color to red
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Color(0xFFD9D9D9),
                        ),
                        SizedBox(height: 4),

                        Text(
                          widget.product.shortDescription,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF004D67),
                          ),
                        ),
                        SizedBox(height: 4),

                        Divider(
                          thickness: 1,
                          color: Color(0xFFD9D9D9),
                        ),
                        SizedBox(height: 10),
                        // Dropdown and Quantity Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Size Dropdown
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: const Color(0xFFD9D9D9),
                                  width: 1.0,
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: DropdownButton<String>(
                                value: selectedSize,
                                hint: const Text(
                                  'Select a Size',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF004D67),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF004D67),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'S',
                                    child: Text('S - Small'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'M',
                                    child: Text('M - Medium'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'L',
                                    child: Text('L - Large'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'XL',
                                    child: Text('XL - Extra Large'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedSize = value;
                                  });
                                },
                                underline: const SizedBox(),
                              ),
                            ),
                            SizedBox(width: 10),
                            // Quantity Control
                            Row(
                              children: [
                                // Minus Button
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(
                                          0xFF004D67), // Button background color
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.white, // Icon color
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantity--;
                                        }
                                      });
                                    },
                                    padding: const EdgeInsets.all(8.0),
                                    iconSize: 30.0, // Icon size
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        8), // Space between the buttons and quantity
                                // Quantity Text with fixed width
                                Container(
                                  width: 50,
                                  height: 40, // Fixed width for quantity
                                  alignment: Alignment.center,
                                  color: Colors.white,
                                  child: Text(
                                    '$quantity',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF004D67),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        8), // Space between the buttons and quantity
                                // Plus Button
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(
                                          0xFF204E2D), // Button background color
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 30,
                                      color: Colors.white, // Icon color
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    padding: const EdgeInsets.all(8.0),
                                    iconSize: 20.0, // Icon size
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFD9D9D9), // Border color
                                  width: 1.0, // Border thickness
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    10.0), // Optional: Rounded corners
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal:
                                      10.0), // Space between dividers and the text
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical:
                                      5.0), // Space between text and border
                              child: const Text(
                                "Description",
                                style: TextStyle(
                                  color: Color(0xFF004D67),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.product.fullDescription,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 14),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFD9D9D9), // Border color
                                  width: 1.0, // Border thickness
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    10.0), // Optional: Rounded corners
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal:
                                      10.0), // Space between dividers and the text
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical:
                                      5.0), // Space between text and border
                              child: const Text(
                                "Shipping & Returns",
                                style: TextStyle(
                                  color: Color(0xFF004D67),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.product.shippingReturns,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 14),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFD9D9D9), // Border color
                                  width: 1.0, // Border thickness
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    10.0), // Optional: Rounded corners
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal:
                                      10.0), // Space between dividers and the text
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical:
                                      5.0), // Space between text and border
                              child: const Text(
                                "Reviews",
                                style: TextStyle(
                                  color: Color(0xFF004D67),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        if (widget.product.reviews.isNotEmpty) ...[
                          Column(
                            children: widget.product.reviews.map((review) {
                              int rating = review['rating_count'] ?? 0;

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          review['name'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          review['review_date'] ?? '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.blueGrey,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          index < rating
                                              ? Icons.star_rounded
                                              : Icons.star_border_rounded,
                                          color: const Color(0xFFF27922),
                                          size: 30,
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      review['review_desc'] ?? '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ] else ...[
                          Text(
                            'No reviews yet.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 1,
                            color: Color(0xFFD9D9D9),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // New Arrival Section
                  SectionTitle(title: 'New Fashion', id: 2),
                  ProductList(tagId: 2, count: 10),
                ],
              ),
            ),
          ),
          // Bottom Buttons (Add to Cart and Wishlist)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: [
            // Add to Cart Button
            Consumer<CartManager>(
              builder: (context, cartManager, child) {
                // Use a default size if selectedSize is null
                final currentSize = selectedSize;
                final isInCart = cartManager.isInCart(widget.product,
                    size: currentSize ?? '');

                return Expanded(
                  child: buildButton(
                    icon: Icons.shopping_cart_rounded,
                    label: isInCart ? 'In Cart' : 'Add To Cart',
                    backgroundColor: const Color(0xFF204E2D),
                    onPressed: () {
                      if (currentSize == null) {
                        // Show a message if size is not selected
                        UIUtils.showSnackbar(
                          context,
                          'Please select a size before adding to the cart!',
                          Colors.red,
                        );
                      } else if (isInCart) {
                        UIUtils.showSnackbar(
                          context,
                          '${widget.product.productName} is already in the cart!',
                          Colors.red,
                        );
                      } else {
                        cartManager.addToCart(
                          widget.product,
                          size: currentSize,
                          quantity: quantity, // Default quantity
                        );
                        UIUtils.showSnackbar(
                          context,
                          '${widget.product.productName} added to cart!',
                          Colors.green,
                        );
                      }
                    },
                  ),
                );
              },
            ),
            // Gap between the buttons
            SizedBox(width: 12), // Adjust the width for your desired gap

            // Wishlist Button
            Consumer<WishlistManager>(
              builder: (context, wishlistManager, child) {
                final isInWishlist =
                    wishlistManager.isInWishlist(widget.product);

                return Expanded(
                  child: buildButton(
                    icon: isInWishlist
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    label: 'Wishlist',
                    backgroundColor: const Color(0xFF004D67),
                    onPressed: () {
                      if (isInWishlist) {
                        wishlistManager.removeFromWishlist(widget.product);
                        UIUtils.showSnackbar(
                          context,
                          '${widget.product.productName} removed from wishlist!',
                          Colors.green,
                        );
                      } else {
                        wishlistManager.addToWishlist(widget.product);
                        UIUtils.showSnackbar(
                          context,
                          '${widget.product.productName} added to wishlist!',
                          Colors.green,
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white, size: 25),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
