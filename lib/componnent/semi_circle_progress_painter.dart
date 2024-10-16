import 'package:flutter/material.dart';
import 'dart:math' show pi;


class SemiCircleProgressPainter extends CustomPainter {
  final double progress;

  SemiCircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    // Draw background semi-circle
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        width: size.width,
        height: size.height * 2,
      ),
      pi, // Start at the left (180 degrees)
      pi, // Sweep angle to cover half-circle (180 degrees)
      false,
      backgroundPaint,
    );

    // Draw progress semi-circle
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        width: size.width,
        height: size.height * 2,
      ),
      pi, // Start at 180 degrees
      pi * progress, // Progress arc based on the percentage
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint for simplicity
  }
}
