import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String title;
  final onTap;

  const MyButton({super.key,
    required this.color,
    required this.textColor,
    required this.title,
    required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
