import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;

  const DatePickerField({super.key, required this.controller});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        validator: (value) {
          // Validate if a date is selected
          if (value == null || value.isEmpty) {
            return 'Date of Birth is required!';
          }
          // You can also validate the date format or other custom validation here
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: Color(0xFF204E2D),
          ),
          labelText: "Date of Birth", // Add this for the label
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: "Date of Birth",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Color(0xFFD9D9D9)), // Default border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Color(0xFFD9D9D9)), // Border color when enabled
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Color(0xFF204E2D),
                width: 1), // Border color when focused
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            // Format the picked date as dd/MM/yyyy
            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

            setState(() {
              widget.controller.text = formattedDate;
            });
          }
        },
      ),
    );
  }
}
