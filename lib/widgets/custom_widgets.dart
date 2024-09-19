// lib/widgets/custom_widgets.dart

import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blueAccent,
  );

  static final InputDecoration textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );

  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blueAccent, // Use `primary` for background color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  );
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final IconData? prefixIcon;
  final Widget? suffixIcon;

  CustomTextFormField({
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: AppStyles.textFieldDecoration.copyWith(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}

class CustomDropdownButtonFormField extends StatelessWidget {
  final String? value;
  final String hint;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  CustomDropdownButtonFormField({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      onChanged: onChanged,
      items: items,
      decoration: AppStyles.textFieldDecoration,
    );
  }
}
