import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;

class LinePainter extends CustomPainter {
  final bool turnedOn;
  final Size size;
  final Image? image;
  final bool isDark;

  const LinePainter({
    required this.turnedOn,
    required this.size,
    required this.isDark,
    this.image,
  });
  static const double _flashLightEndSize = 200;

  @override
  void paint(Canvas canvas, Size size) {
    final Color color = isDark ? Color(0xfff9eed6) : Colors.black87;
    final turnedOffColor = isDark ? Colors.black : Colors.white;
    final path = Path();
    final hypotenuse = sqrt(pow(size.width, 2) + pow(size.height, 2));
    path.moveTo(-0, size.height + 100);
    path.lineTo(-_flashLightEndSize, -hypotenuse * 0.8);
    path.lineTo(_flashLightEndSize, -hypotenuse * 0.8);
    path.lineTo(-0, size.height + 100);
    // TODO: Need a better way to turn off light, instead of just turning the rays black.
    canvas.drawShadow(
      path,
      turnedOn ? color : turnedOffColor,
      turnedOn ? 5 : 0,
      turnedOn,
    );
    if (image != null) {
      final paint = Paint();
      canvas.drawImage(image!, Offset(-28, size.height * 0.92), paint);
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return oldDelegate.turnedOn != turnedOn ||
        oldDelegate.size != size ||
        oldDelegate.image != image ||
        oldDelegate.isDark != isDark;
  }

  @override
  bool? hitTest(Offset position) {
    if (position.dx < 50 && position.dy > size.height - 80) {
      return true;
    }
    return false;
  }
}
