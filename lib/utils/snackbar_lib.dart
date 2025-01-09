import 'package:flutter/material.dart';

class UIUtils {
  static void showSnackbar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
