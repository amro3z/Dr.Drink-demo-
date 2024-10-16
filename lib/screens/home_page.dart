import 'package:flutter/material.dart';
import 'dart:math';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  double progress = 0.5; // 50% progress for 1500ml out of 3000ml

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Water icons on the left and right
            Positioned(
              left: 50,
              top: 150,
              child: Icon(
                Icons.water_drop,
                color: Colors.blue[300],
                size: 30,
              ),
            ),
            Positioned(
              right: 50,
              top: 150,
              child: Icon(
                Icons.water_drop,
                color: Colors.blue[300],
                size: 30,
              ),
            ),
            // Semi-circle custom painter
            CustomPaint(
              size: const Size(200, 100), // Size for the semi-circle
              painter: SemiCircleProgressPainter(progress),
            ),
            // Centered text inside the semi-circle
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '1500/3000ml',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Daily Drink Target',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '200ml',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

void main() {
  runApp(const MaterialApp(
    home: WaterTracker(),
    debugShowCheckedModeBanner: false,
  ));
}
