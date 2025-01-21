import 'package:demo/model/product_service.dart';
import 'package:demo/widgets/custom_bottom_nav_bar.dart';
import 'package:demo/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

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
                  // Image Carousel
                  CarouselSlider(
                    items: product.productImages.map((image) {
                      return Image.asset(
                        image,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 450,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                    ),
                  ),
                  // Product Details
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          product.productName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('Product Code: ${product.productCode}'),
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                i < product.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.orange,
                                size: 16,
                              ),
                            const SizedBox(width: 8),
                            Text(
                              '(${product.reviewCount} Reviews)',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\$${product.discountPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '\$${product.actualPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(product.shortDescription),
                        const SizedBox(height: 16),
                        // Dropdown and Quantity Controls
                        Row(
                          children: [
                            DropdownButton<String>(
                              value: 'M',
                              items: ['S', 'M', 'L', 'XL']
                                  .map(
                                    (size) => DropdownMenuItem(
                                      value: size,
                                      child: Text(size),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {},
                            ),
                            const Spacer(),
                            IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  // Handle decrease quantity
                                }),
                            const Text('1'),
                            IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  // Handle increase quantity
                                }),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        // Tabs
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TabBar(
                                labelColor: Colors.black,
                                tabs: [
                                  Tab(text: 'Shipping & Returns'),
                                  Tab(text: 'Reviews'),
                                ],
                              ),
                              SizedBox(
                                height: 200,
                                child: TabBarView(
                                  children: [
                                    Text(product.shippingReturns),
                                    Column(
                                      children: product.reviews.map((review) {
                                        return ListTile(
                                          title: Text(
                                              review['reviewerName'] ?? ''),
                                          subtitle:
                                              Text(review['reviewText'] ?? ''),
                                          trailing:
                                              Text(review['reviewDate'] ?? ''),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // New Arrival Section
                  SectionTitle(title: 'Sale Under 20\$', id: 3),
                  ProductList(tagId: 3),
                ],
              ),
            ),
          ),
          // Bottom Buttons (Add to Cart and Wishlist)

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 10), // Vertical padding removed
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: const Text(
                        'Add To Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF204E2D), // Background color
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10), // Padding inside button
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: const Text(
                        'Wishlist',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF004D67), // Background color
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10), // Padding inside button
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
