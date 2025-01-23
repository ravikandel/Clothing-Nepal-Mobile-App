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

  // static void showSnackbarWithAction({
  //   required BuildContext context,
  //   required String message,
  //   required Color backgroundColor,
  //   required String actionLabel,
  //   required VoidCallback action,
  // }) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       backgroundColor: backgroundColor,
  //       action: SnackBarAction(
  //         label: actionLabel,
  //         textColor: Colors.white,
  //         onPressed: action,
  //       ),
  //     ),
  //   );
  // }
}
