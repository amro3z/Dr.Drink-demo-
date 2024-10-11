import 'package:flutter/material.dart';

class AppBaricon extends StatelessWidget {
  AppBaricon({super.key, required this.path, this.onTap, this.color});
  final String path;
  final VoidCallback? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Image.asset(
            path,
            width: 40,
            height: 40,
            color: color,
          ),
        ),
      ),
    );
  }
}
