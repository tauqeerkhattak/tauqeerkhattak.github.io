import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app_colors.dart';

class CirclePainter extends CustomPainter {
  final byQuarterAngles = [
    30,
    60,
    120,
    150,
    210,
    240,
    300,
    330,
  ];
  final quarterAngles = [
    90,
    180,
    270,
    360,
  ];
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerOffset = Offset(width / 2, height / 2);
    final radius = height / 2;
    final smallRadius = radius - 15;
    final smallerRadius = radius - 20;
    Paint paint = Paint()
      ..color = AppColors.silver
      ..strokeWidth = 15
      ..style = PaintingStyle.fill;

    for (final angle in quarterAngles) {
      final x = radius * math.sin(math.pi * 2 * (angle / 360));
      final y = radius * math.cos(math.pi * 2 * (angle / 360));
      final x2 = smallerRadius * math.sin(math.pi * 2 * (angle / 360));
      final y2 = smallerRadius * math.cos(math.pi * 2 * (angle / 360));
      final p1 = Offset(x, y) + centerOffset;
      final p2 = Offset(x2, y2) + centerOffset;
      canvas.drawLine(p1, p2, paint);
    }

    paint.strokeWidth = 5;
    for (final angle in byQuarterAngles) {
      final x = radius * math.sin(math.pi * 2 * (angle / 360));
      final y = radius * math.cos(math.pi * 2 * (angle / 360));
      final x2 = smallRadius * math.sin(math.pi * 2 * (angle / 360));
      final y2 = smallRadius * math.cos(math.pi * 2 * (angle / 360));
      final p1 = Offset(x, y) + centerOffset;
      final p2 = Offset(x2, y2) + centerOffset;
      canvas.drawLine(p1, p2, paint);
    }
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 8;
    canvas.drawCircle(centerOffset, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
