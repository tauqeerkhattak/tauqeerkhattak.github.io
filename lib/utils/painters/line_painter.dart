import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;

class LinePainter extends CustomPainter {
  final bool turnedOn;
  final Size screenSize;
  final Image? image;
  final bool isDark;
  final double angle;
  final bool roomLight;

  const LinePainter({
    required this.turnedOn,
    required this.screenSize,
    required this.isDark,
    required this.angle,
    required this.roomLight,
    this.image,
  });

  static const double _flashLightEndSize = 250;

  @override
  void paint(Canvas canvas, Size size) {
    if (roomLight) return;

    final Paint maskPaint = Paint()
      ..color = isDark ? Colors.black : Colors.white;

    // Create a layer for the mask
    canvas.saveLayer(Offset.zero & size, Paint());

    // 1. Draw the "darkness" covering everything
    canvas.drawRect(Offset.zero & size, maskPaint);

    if (turnedOn) {
      // 2. Clear the "flashlight cone" using BlendMode.dstOut
      final Paint clearPaint = Paint()
        ..blendMode = BlendMode.dstOut
        ..isAntiAlias = true;

      final path = Path();
      final hypotenuse = sqrt(pow(size.width, 2) + pow(size.height, 2)) * 1.5;

      // Pivot point is bottom left
      final pivot = Offset(0, size.height);

      // We need to rotate the path manually based on the angle
      // because Transform.rotate might not work well with dstOut on the same layer
      // Or we can just use canvas.translate/rotate
      canvas.save();
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(angle); // Rotate clockwise to follow mouse

      path.moveTo(0, 0);
      path.lineTo(-_flashLightEndSize, -hypotenuse);
      path.lineTo(_flashLightEndSize, -hypotenuse);
      path.close();

      canvas.drawPath(path, clearPaint);

      // Add a subtle glow at the edge of the light
      final Paint glowPaint = Paint()
        ..color = (isDark ? const Color(0xfff9eed6) : Colors.yellow)
            .withValues(alpha: 0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
      canvas.drawPath(path, glowPaint);

      canvas.restore();
    }

    canvas.restore();

    // Draw the lamp image at the pivot point (bottom left)
    if (image != null) {
      canvas.save();
      canvas.translate(0, size.height);
      canvas.rotate(angle);
      final paint = Paint();
      canvas.drawImage(image!, Offset(-28, -size.height * 0.08), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return oldDelegate.turnedOn != turnedOn ||
        oldDelegate.screenSize != screenSize ||
        oldDelegate.image != image ||
        oldDelegate.isDark != isDark ||
        oldDelegate.angle != angle ||
        oldDelegate.roomLight != roomLight;
  }
}
