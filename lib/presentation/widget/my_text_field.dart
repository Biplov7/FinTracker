import 'package:ecommerce/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool hide;
  final IconButton? icon;
  final TextInputType? keyboardType;
  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.icon,
    this.hide = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hide,
      decoration: InputDecoration(
        hintText: label,
        suffixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
