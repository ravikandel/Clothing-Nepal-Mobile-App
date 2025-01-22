// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:demo/utils/wishlist_manager.dart';
// import 'package:demo/utils/snackbar_lib.dart';
// import 'package:demo/models/product.dart'; // Assuming you have the Product model

// class ProductScreen extends StatelessWidget {
//   final Product product;

//   const ProductScreen({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(product.productName)),
//       body: Column(
//         children: [
//           // Other product details...

//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               child: Row(
//                 children: [
//                   // Add to Cart Button
//                   Expanded(
//                     child: buildButton(
//                       icon: Icons.shopping_cart_rounded,
//                       label: 'Add To Cart',
//                       backgroundColor: Color(0xFF204E2D),
//                       onPressed: () {},
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   // Wishlist Button
//                   Expanded(
//                     child: Consumer<WishlistManager>(
//                       builder: (context, wishlistManager, child) {
//                         final isInWishlist = wishlistManager.isInWishlist(product);

//                         return buildButton(
//                           icon: isInWishlist
//                               ? Icons.favorite_rounded // Filled heart for in wishlist
//                               : Icons.favorite_border_rounded, // Empty heart for not in wishlist
//                           label: 'Wishlist',
//                           backgroundColor: Color(0xFF004D67),
//                           onPressed: () {
//                             if (isInWishlist) {
//                               wishlistManager.removeFromWishlist(product);
//                               UIUtils.showSnackbar(
//                                 context,
//                                 '${product.productName} removed from wishlist!',
//                                 Colors.red,
//                               );
//                             } else {
//                               wishlistManager.addToWishlist(product);
//                               UIUtils.showSnackbar(
//                                 context,
//                                 '${product.productName} added to wishlist!',
//                                 Colors.green,
//                               );
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // A method to build the button widget
//   Widget buildButton({
//     required IconData icon,
//     required String label,
//     required Color backgroundColor,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         primary: backgroundColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       onPressed: onPressed,
//       icon: Icon(icon, color: Colors.white),
//       label: Text(
//         label,
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }
