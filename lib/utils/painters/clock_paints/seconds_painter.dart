import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app_colors.dart';

class SecondsPainter extends CustomPainter {
  // final int seconds;
  final double value;

  SecondsPainter({
    // required this.seconds,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Variables
    final width = size.width;
    final height = size.height;
    final centerOffset = Offset(width / 2, height / 2);
    final radius = (height / 2) - 30;
    Paint paint = Paint()
      ..color = AppColors.silver
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final newSeconds = value;
    final secondAngle = 180 - (newSeconds * 6);
    final x = radius * math.sin(math.pi * 2 * (secondAngle / 360));
    final y = radius * math.cos(math.pi * 2 * (secondAngle / 360));
    final secondOffset = Offset(x, y);
    final resultantOffset = secondOffset + centerOffset;
    canvas.drawLine(centerOffset, resultantOffset, paint);
  }

  @override
  bool shouldRepaint(SecondsPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
