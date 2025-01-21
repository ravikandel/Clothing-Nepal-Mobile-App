import 'package:demo/screens/category_product_screen.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final int id;

  const SectionTitle({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF004D67)),
          ),
          TextButton(
            onPressed: () {
              if (id == 0) {
              } else {
                // Navigate to the CategoryProductsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductsScreen(
                      tagId: id,
                      categoryName: title,
                    ),
                  ),
                );
              }
            },
            child: Text(
              'View more →',
              style: TextStyle(
                  color: const Color(0xFF204E2D),
                  fontSize: 14,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
