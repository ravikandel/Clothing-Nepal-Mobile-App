// import 'package:flutter/material.dart';
// import 'package:demo/widgets/banner_slider.dart';
// import 'package:demo/widgets/custom_bottom_nav_bar.dart';
// import 'package:demo/model/product_service.dart'; // Import the service

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFAFAFA),
//       appBar: CustomAppBar(title: 'Clothing Nepal'),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               BannerSlider(),
//               SectionTitle(title: 'Top Picks'),
//               ProductList(),
//               SectionTitle(title: 'New Arrivals'),
//               ProductList(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(),
//     );
//   }
// }

// class SectionTitle extends StatelessWidget {
//   final String title;

//   const SectionTitle({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFF004D67)),
//           ),
//           TextButton(
//             onPressed: () {},
//             child: Text(
//               'View more',
//               style: TextStyle(
//                   color: const Color(0xFF204E2D),
//                   fontSize: 14,
//                   decoration: TextDecoration.underline,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProductList extends StatelessWidget {
//   const ProductList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 350.0,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: ProductCard(),
//           );
//         },
//       ),
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   const ProductCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 185.0,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//         border: Border.all(
//           color: Color(0xFFD9D9D9), // Border color
//           width: 1.0, // Border width
//           style: BorderStyle.solid, // Border style
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 250.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//               image: DecorationImage(
//                 image: AssetImage('assets/images/product/item1.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Lorem Ipsum Dolor',
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//                 Row(
//                   children: List.generate(
//                           4,
//                           (index) => Icon(Icons.star,
//                               color: const Color(0xFFF27922), size: 16)) +
//                       [
//                         Icon(Icons.star_border,
//                             color: const Color(0xFFF27922), size: 16)
//                       ],
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   '\$15.18',
//                   style: TextStyle(
//                     color: Colors.teal,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   '\$15.18',
//                   style: TextStyle(
//                     decoration: TextDecoration.lineThrough,
//                     color: Colors.grey,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
