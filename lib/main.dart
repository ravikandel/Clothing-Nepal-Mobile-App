import 'package:demo/screens/cart_screen.dart';
import 'package:demo/screens/checkout_screen.dart';
import 'package:demo/utils/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/utils/wishlist_manager.dart';
import 'package:demo/screens/categories_screen.dart';
import 'package:demo/screens/base_layout.dart';
import 'package:demo/screens/wishlist_screen.dart';
import 'package:demo/screens/splash_screen.dart';
import 'package:demo/screens/success_screen.dart';
import 'package:demo/screens/signin_screen.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/resetpassword_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartManager()),
        ChangeNotifierProvider(create: (_) => WishlistManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clothing Nepal',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/success': (context) => SuccessScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/reset-password': (context) => ResetPasswordScreen(),
        '/home': (context) => BaseLayout(
              selectedIndex: 0,
            ),
        '/categories': (context) => CategoriesScreen(),
        '/wishlist': (context) => WishlistScreen(),
        '/cart': (context) => CartScreen(),
        '/checkout': (context) => CheckoutScreen(),
      },
    );
  }
}
