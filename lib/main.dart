import 'package:demo/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/splash_screen.dart';
import 'package:demo/screens/success_screen.dart';
import 'package:demo/screens/signin_screen.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/resetpassword_screen.dart';
import 'package:demo/screens/home_screen.dart';
//import 'screens/test.dart';

void main() {
  runApp(const MyApp());
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
        '/home': (context) => HomeScreen(),
        '/categories': (context) => CategoriesScreen(),
        //'/test': (context) => JsonListView(),
      },
    );
  }
}
