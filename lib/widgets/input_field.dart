import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const InputField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (_errorText == null && widget.validator != null) {
            _errorText = widget.validator!(value);
          }
          return _errorText;
        },
        onChanged: (value) {
          setState(() {
            _errorText = null; // Clear error while typing
          });
        },
        decoration: InputDecoration(
          labelText: widget.hintText, // Add this for the label
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          prefixIcon: Icon(widget.icon, color: const Color(0xFF204E2D)),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF204E2D), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
          errorText: _errorText, // Display error text
        ),
      ),
    );
  }
}
