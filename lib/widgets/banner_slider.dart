import 'dart:convert';

import 'package:demo/model/category_service.dart';
import 'package:demo/screens/category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  BannerSliderState createState() => BannerSliderState();
}

class BannerSliderState extends State<BannerSlider> {
  final List<Map<String, dynamic>> banners = [
    {
      'image': 'assets/images/slider/banner1.jpg',
      'title': 'Kids Wear',
      'subtitle': 'Stay cool with our latest styles',
      'categoryId': 3,
      'categoryName': 'Kids',
    },
    {
      'image': 'assets/images/slider/banner2.jpg',
      'title': 'Winter Wear',
      'subtitle': 'Keep warm with elegance',
      'categoryId': 4,
      'categoryName': 'Wool',
    },
    {
      'image': 'assets/images/slider/banner3.jpg',
      'title': 'Spring Essentials',
      'subtitle': 'Bloom in style this season',
      'categoryId': 6,
      'categoryName': 'Shawl',
    },
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Center(
              child: SizedBox(
                height: 220.0,
                child: PageView.builder(
                  itemCount: banners.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(banners[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(180, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0),
                            ],
                            stops: [0.0, 1.0],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              banners[index]['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              banners[index]['subtitle']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to the CategoryProductsScreen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryProductsScreen(
                                      categoryId: banners[index]['categoryId'],
                                      categoryName: banners[index]
                                          ['categoryName'],
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: const Text('Shop Now →'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(banners.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8.0,
                width: currentIndex == index ? 20.0 : 8.0,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.white
                      : Colors.white.withAlpha(128),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class CategoriesSlider extends StatefulWidget {
  const CategoriesSlider({super.key});

  @override
  CategoriesSliderState createState() => CategoriesSliderState();
}

class CategoriesSliderState extends State<CategoriesSlider> {
  List<Category> banners = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadBanners();
  }

  Future<void> loadBanners() async {
    try {
      String jsonString = await rootBundle.loadString('assets/categories.json');
      List<dynamic> jsonResponse = jsonDecode(jsonString);
      setState(() {
        banners = jsonResponse
            .map((category) => Category.fromJson(category))
            .toList();
      });
    } catch (e) {
      // print('Error loading banners: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return banners.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 220.0,
                      child: PageView.builder(
                        itemCount: banners.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final banner = banners[index];

                          return Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(banner.categoryImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(180, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0),
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    banner.categoryName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryProductsScreen(
                                            categoryId: banner.categoryId,
                                            categoryName: banner.categoryName,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                    child: const Text('Browse All →'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(banners.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8.0,
                      width: currentIndex == index ? 20.0 : 8.0,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Colors.white
                            : Colors.white.withAlpha(128),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
  }
}
