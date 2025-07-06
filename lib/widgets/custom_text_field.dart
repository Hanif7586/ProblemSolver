
import 'package:flutter/material.dart';

import 'color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController? controller;
  final bool isPassword;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? errorText;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    this.controller,
    this.isPassword = false,
    this.onTap,
    this.readOnly = false,
    this.keyboardType,
    this.validator,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        readOnly: readOnly || onTap != null,
        onTap: onTap,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          floatingLabelStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(
              color: primaryColor,
              width: 2,
            ),
          ),
          errorText: errorText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}