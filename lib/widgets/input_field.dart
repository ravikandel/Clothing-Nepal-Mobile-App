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
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _errorText = null; // Clear error when field gains focus
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
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

class ShippingInputField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isRequired; // New parameter to determine if the field is required

  const ShippingInputField({
    super.key,
    required this.labelText,
    this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isRequired = false, // Default to not required
  });

  @override
  State<ShippingInputField> createState() => _ShippingInputFieldState();
}

class _ShippingInputFieldState extends State<ShippingInputField> {
  String? _errorText;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _errorText = null; // Clear error when field gains focus
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        validator: (value) {
          if (widget.isRequired && (value == null || value.trim().isEmpty)) {
            return '{$widget.labelText} is required!';
          }
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
          labelText:
              (widget.isRequired) ? '${widget.labelText} *' : widget.labelText,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
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
          errorText: _errorText,
        ),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black54, // Set the input text color to red
        ),
      ),
    );
  }
}
