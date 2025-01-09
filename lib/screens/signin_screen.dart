import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome package
import '../widgets/input_field.dart';
import '../widgets/password_input_field.dart';
import '../utils/snackbar_lib.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  _buildSignInButton(context),

                  const SizedBox(height: 16),

                  // Social Login Buttons
                  _buildSocialButtons(),

                  const SizedBox(height: 16),

                  // Forgot Password and Sign Up Links
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
          "Sign in to continue",
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
        PasswordInputField(
          hintText: "Password",
          controller: passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required!';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters!';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _handleSignIn(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF204E2D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const Text(
          "Sign In",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _handleSignIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (_isValidLogin(email, password)) {
        UIUtils.showSnackbar(
            context, 'Success. Login successful!', Colors.green);
        // Navigator.pushReplacementNamed(context, '/success',
        //     arguments: 'Login successful!');
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        UIUtils.showSnackbar(
            context, 'Error. Email or password is incorrect!', Colors.red);
      }
    }
  }

  bool _isValidLogin(String email, String password) {
    return email == "a@a.com" && password == "aaaaaa";
  }

  Widget _buildSocialButtons() {
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("OR", style: TextStyle(color: Colors.grey)),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                color: Color(0xFFD9D9D9),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSocialButton(
          icon: FontAwesomeIcons.google,
          label: "Login with Google",
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        _buildSocialButton(
          icon: FontAwesomeIcons.facebookF,
          label: "Login with Facebook",
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: FaIcon(
          icon,
          color: const Color(0xFF204E2D),
          size: 20,
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF004D67),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          side: const BorderSide(color: Color(0xFFD9D9D9)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
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
        TextButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/reset-password'),
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              color: Color(0xFF204E2D),
              fontWeight: FontWeight.w500,
            ),
          ),
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
