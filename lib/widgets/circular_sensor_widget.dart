import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularSensorWidget extends StatelessWidget {
  final double value;
  final String label;
  final Color color;
  final String symbol;

  const CircularSensorWidget({
    super.key,
    required this.value,
    required this.label,
    required this.color,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(150, 150),
            painter: CircularSensorPainter(
              value: value,
              color: color,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${value.toStringAsFixed(0)} $symbol',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 16, color: color),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircularSensorPainter extends CustomPainter {
  final double value;
  final Color color;

  CircularSensorPainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 10;
    final backgroundPaint =
        Paint()
          ..color = color.withOpacity(0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10;
    final progressPaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, backgroundPaint);
    final progressAngle = 2 * math.pi * (value / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
