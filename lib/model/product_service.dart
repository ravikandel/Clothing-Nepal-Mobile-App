import 'dart:convert';
import 'package:demo/screens/product_screen.dart';
import 'package:demo/utils/snackbar_lib.dart';
import 'package:demo/utils/wishlist_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product {
  final int productId;
  final String productName;
  final String productCode;
  final int categoryId;
  final String categoryName;
  final List<Map<String, dynamic>> tags;
  final List<String> productImages;
  final int reviewCount;
  final int rating;
  final double actualPrice;
  final double discountPrice;
  final String shortDescription;
  final String fullDescription;
  final String shippingReturns;
  final List<Map<String, dynamic>> reviews;

  Product({
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.categoryId,
    required this.categoryName,
    required this.tags,
    required this.productImages,
    required this.reviewCount,
    required this.rating,
    required this.actualPrice,
    required this.discountPrice,
    required this.shortDescription,
    required this.fullDescription,
    required this.shippingReturns,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productid'],
      productName: json['productname'],
      productCode: json['productcode'],
      categoryId: json['categoryid'],
      categoryName: json['categoryname'],
      tags: List<Map<String, dynamic>>.from(json['tags']),
      productImages: json['product_images'] != null &&
              (json['product_images'] as List).isNotEmpty
          ? List<String>.from(json['product_images']
              .map((image) => 'assets/images/product/$image'))
          : ['assets/images/product/default.jpg'],
      // Default image
      reviewCount: json['reviewcount'],
      rating: json['rating'],
      actualPrice: json['actualprice'],
      discountPrice: json['discountprice'],
      shortDescription: json['shortdescription'],
      fullDescription: json['fulldescription'],
      shippingReturns: json['shipping_returns'],
      reviews: List<Map<String, dynamic>>.from(json['reviews']),
    );
  }
}

class ProductService {
  // Load and parse JSON file
  Future<List<Product>> loadProducts() async {
    String jsonString = await rootBundle.loadString('assets/products.json');
    List<dynamic> jsonResponse = jsonDecode(jsonString);
    return jsonResponse.map((product) => Product.fromJson(product)).toList();
  }

  // Get filtered products based on parameters
  Future<List<Product>> getFilteredProducts({
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    int? tagId,
    int count = 10,
  }) async {
    List<Product> products = await loadProducts();

    // Apply filters
    if (categoryId != null) {
      products = products
          .where((product) => product.categoryId == categoryId)
          .toList();
    }
    if (minPrice != null) {
      products = products
          .where((product) => product.discountPrice >= minPrice)
          .toList();
    }
    if (maxPrice != null) {
      products = products
          .where((product) => product.discountPrice <= maxPrice)
          .toList();
    }
    if (tagId != null) {
      products = products.where((product) {
        return product.tags.any((tag) => tag['tagid'] == tagId);
      }).toList();
    }

    return products.take(count).toList();
  }
}

class ProductList extends StatelessWidget {
  final int tagId;
  final int count;

  const ProductList({super.key, required this.tagId, this.count = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.0,
      child: FutureBuilder<List<Product>>(
        future: ProductService().getFilteredProducts(
            tagId: tagId, count: count), // Fetch products based on tagId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available.'));
          }

          List<Product> products = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ProductCard(
                    product: products[index]), // Pass the product data
              );
            },
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ),
        );
      },
      child: Container(
        width: 170.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFD9D9D9),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 160.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(product.productImages[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Consumer<WishlistManager>(
                    builder: (context, wishlistManager, child) {
                      final isInWishlist =
                          wishlistManager.isInWishlist(product);

                      return GestureDetector(
                        onTap: () {
                          if (isInWishlist) {
                            wishlistManager.removeFromWishlist(product);
                            UIUtils.showSnackbar(
                                context,
                                '${product.productName} removed from wishlist!',
                                Colors.red);
                          } else {
                            wishlistManager.addToWishlist(product);
                            UIUtils.showSnackbar(
                                context,
                                '${product.productName} added to wishlist!',
                                Colors.green);
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            isInWishlist
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Color(0xFFF27922),
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF004D67)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: List.generate(
                          product.rating,
                          (index) => Icon(
                            Icons.star_rounded,
                            color: Color(0xFFF27922),
                            size: 16,
                          ),
                        ) +
                        List.generate(
                          5 - product.rating,
                          (index) => Icon(
                            Icons.star_border_rounded,
                            color: Color(0xFFF27922),
                            size: 16,
                          ),
                        ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (product.discountPrice > 0.0) ...[
                        Text(
                          '\$${product.discountPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Color(0xFF204E2D),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        if (product.actualPrice > 0.0) SizedBox(width: 4),
                      ],
                      if (product.actualPrice > 0.0)
                        Text(
                          '\$${product.actualPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red,
                            decorationColor: Colors.red,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  if (product.discountPrice <= 0.0 &&
                      product.actualPrice <= 0.0)
                    Text(
                      'Price not available!',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
