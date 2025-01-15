import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Category {
  final int categoryId;
  final String categoryName;
  final String categoryImage;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryid'],
      categoryName: json['categoryname'],
      categoryImage: //json['categoryimage'] ??
          'assets/images/slider/banner1.jpg', // Default image
    );
  }
}

class CategoryService {
  // Load and parse categories JSON file
  Future<List<Category>> loadCategories() async {
    String jsonString = await rootBundle.loadString('assets/categories.json');
    List<dynamic> jsonResponse = jsonDecode(jsonString);
    return jsonResponse.map((category) => Category.fromJson(category)).toList();
  }

  // Get filtered products based on parameters
  Future<List<Category>> getAllCategories() async {
    List<Category> categories = await loadCategories();
    return categories.toList();
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 735.0,
      child: FutureBuilder<List<Category>>(
        future: CategoryService().getAllCategories(), // Fetch categories
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories available.'));
          }

          List<Category> categories = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                width: 180,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CategoryCard(
                  id: category.categoryId,
                  title: category.categoryName,
                  subtitle: 'Up to 70% OFF', // Placeholder subtitle
                  imageUrl: category.categoryImage,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;

  const CategoryCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(10), // Rounded corners
        border: Border.all(
          color: Color(0xFF004D67), // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF004D67),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button tap
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF004D67),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          color: Color(0xFF004D67),
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: const Text("Shop Now →"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
