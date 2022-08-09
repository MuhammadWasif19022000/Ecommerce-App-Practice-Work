// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_practice/constants.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String? hintText;
  final Function(String)? onchanged;
  final Function(String)? onsubmit;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool isPasswordField;
  const CustomField(
      {Key? key,
      this.hintText,
      this.onsubmit,
      this.focusNode,
      required this.onchanged,
      this.textInputAction,
      required this.isPasswordField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    // ignore: avoid_unnecessary_containers
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onSubmitted: onsubmit,
        onChanged: onchanged,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "Hint Text..",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 20,
          ),
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
