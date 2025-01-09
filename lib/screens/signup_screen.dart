import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/password_input_field.dart';
import '../widgets/date_picker_field.dart';
import '../utils/snackbar_lib.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateofBirthController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

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
          "Create a new account",
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
        // Full Name
        InputField(
          icon: Icons.person,
          hintText: "Full Name",
          controller: fullnameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Full Name is required!';
            }
            return null;
          },
        ),

        // Date of birth
        DatePickerField(controller: dateofBirthController),

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

        // Password
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

        // Confirm Password
        PasswordInputField(
          hintText: "Confirm Password",
          controller: cpasswordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Confirm Password is required!';
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
        onPressed: () => _handleSignUp(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF204E2D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _handleSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final fullname = fullnameController.text.trim();
      final dob = dateofBirthController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final cpassword = cpasswordController.text.trim();

      if (_isValidSignUp(fullname, dob, email, password, cpassword)) {
        UIUtils.showSnackbar(
            context, 'Success. Account created succesfully!', Colors.green);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        UIUtils.showSnackbar(
            context, 'Error. Please try again later!', Colors.red);
      }
    }
  }

  // Sign up logic goes here
  bool _isValidSignUp(String fullname, String dob, String email,
      String password, String cpassword) {
    // Signup logic goes here
    return email == "a@a.com" && password == cpassword;
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
              "Have an account?",
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
      ],
    );
  }
}
