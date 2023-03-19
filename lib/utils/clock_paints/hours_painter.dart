import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../app_colors.dart';

class HoursPainter extends CustomPainter {
  final double value;

  HoursPainter({
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerOffset = Offset(width / 2, height / 2);
    final radius = (height / 2) - 100;
    Paint paint = Paint()
      ..color = AppColors.silver
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final newHours = value;
    final hoursAngle = 180 - (newHours * 30);
    final x = radius * math.sin(math.pi * 2 * (hoursAngle / 360));
    final y = radius * math.cos(math.pi * 2 * (hoursAngle / 360));
    final secondOffset = Offset(x, y);
    final resultantOffset = secondOffset + centerOffset;
    canvas.drawLine(centerOffset, resultantOffset, paint);
  }

  @override
  bool shouldRepaint(HoursPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
