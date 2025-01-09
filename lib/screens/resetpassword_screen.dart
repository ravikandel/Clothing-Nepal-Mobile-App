import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../utils/snackbar_lib.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),

                  // Logo Section
                  _buildLogo(),

                  // Form Section
                  _buildFormFields(),

                  // Sign In Button
                  _buildSignUpButton(context),

                  const SizedBox(height: 16),

                  // Sign In and Sign Up Links
                  _buildFooterLinks(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF204E2D),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.diamond,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Clothing Nepal",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF204E2D),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Reset your password",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        // Email
        InputField(
          icon: Icons.email,
          hintText: "Your Email",
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required!';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Enter a valid email!';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _handleReset(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF204E2D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const Text(
          "Reset Password",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _handleReset(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();

      if (_isValidReset(email)) {
        UIUtils.showSnackbar(
            context, 'Success. Please check your email!', Colors.green);
        Navigator.pushReplacementNamed(context, '/');
      } else {
        UIUtils.showSnackbar(
            context, 'Error. Please try again later!', Colors.red);
      }
    }
  }

  bool _isValidReset(String email) {
    // Signup logic goes here
    return email == "a@a.com";
  }

  Widget _buildFooterLinks(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: Divider(
                thickness: 1,
                color: Color(0xFFD9D9D9),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Back to",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/signin'),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Color(0xFF004D67),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/signup'),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Color(0xFF004D67),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
