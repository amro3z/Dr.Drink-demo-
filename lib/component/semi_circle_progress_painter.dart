import 'package:flutter/material.dart';
import 'dart:math' show pi;

class SemiCircleProgressPainter extends CustomPainter {
  final double progress; // Should be between 0.0 and 1.0

  SemiCircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Background paint
    final Paint backgroundPaint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    // Progress paint
    final Paint progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    // Rect defining the semi-circle area
    final Rect arcRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height),
      width: size.width,
      height: size.height * 2,
    );

    // Draw the background semi-circle (180 degrees)
    canvas.drawArc(
      arcRect,
      pi, // Start at 180 degrees (left side)
      pi, // Sweep 180 degrees to complete the semi-circle
      false,
      backgroundPaint,
    );

    // Clamp progress to avoid overflow (between 0.0 and 1.0)
    final double clampedProgress = progress.clamp(0.0, 1.0);

    // Draw the progress arc based on clamped progress
    canvas.drawArc(
      arcRect,
      pi, // Start at 180 degrees
      pi * clampedProgress, // Sweep angle based on progress
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint to reflect changes
  }
}
