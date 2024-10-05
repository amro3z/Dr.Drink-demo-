import 'package:flutter/material.dart';

class AppBaricon extends StatelessWidget {
  AppBaricon({super.key, required this.path, this.onTap});
  final String path;
  final VoidCallback? onTap;
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
          ),
        ),
      ),
    );
  }
}
