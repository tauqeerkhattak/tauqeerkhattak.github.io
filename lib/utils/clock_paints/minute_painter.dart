import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../app_colors.dart';

class MinutePainter extends CustomPainter {
  // final int minutes;
  final double value;

  MinutePainter({
    // required this.minutes,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerOffset = Offset(width / 2, height / 2);
    final radius = (height / 2) - 60;
    Paint paint = Paint()
      ..color = AppColors.silver
      ..strokeWidth = 7.5
      ..strokeCap = StrokeCap.round;

    final newMinutes = value;
    final minuteAngle = 180 - (newMinutes * 6);
    final x = radius * math.sin(math.pi * 2 * (minuteAngle / 360));
    final y = radius * math.cos(math.pi * 2 * (minuteAngle / 360));
    final secondOffset = Offset(x, y);
    final resultantOffset = secondOffset + centerOffset;
    canvas.drawLine(centerOffset, resultantOffset, paint);
  }

  @override
  bool shouldRepaint(MinutePainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
