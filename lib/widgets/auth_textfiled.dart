import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.isPass,
    required this.hintText,
  });

  final TextEditingController controller;
  final bool isPass;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom : 14.0,),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(16),
        ),
        obscureText: isPass,
      ),
    );
  }
}
