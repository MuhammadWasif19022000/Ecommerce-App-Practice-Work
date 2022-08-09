import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;

  const CustomBtn({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        // ignore: prefer_const_constructors

        // ignore: prefer_const_constructors
        child: Text(
          text ?? "Text",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
