// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class CustomBtn1 extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool isloading;

  const CustomBtn1({
    Key? key,
    required this.text,
    this.onPressed,
    required this.isloading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isloading = isloading ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),

        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        // ignore: prefer_const_constructors

        // ignore: prefer_const_constructors
        child: Stack(
          children: [
            Visibility(
              visible: isloading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isloading,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
