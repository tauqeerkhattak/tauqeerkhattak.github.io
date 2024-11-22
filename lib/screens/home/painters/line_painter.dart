import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;

class LinePainter extends CustomPainter {
  final bool turnedOn;
  final Size size;
  final Image? image;

  const LinePainter({
    required this.turnedOn,
    required this.size,
    this.image,
  });
  static const double _flashLightEndSize = 200;
  static const Color _color = Color(0xfff9eed6);

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      final paint = Paint();
      canvas.drawImage(image!, Offset(-28, size.height * 0.91), paint);
    }
    final path = Path();
    final hypotenuse = sqrt(pow(size.width, 2) + pow(size.height, 2));
    path.moveTo(0, size.height);
    path.lineTo(-_flashLightEndSize, -hypotenuse);
    path.lineTo(_flashLightEndSize, -hypotenuse);
    path.lineTo(0, size.height);
    // TODO: Need a better way to turn off light, instead of just turning the rays black.
    canvas.drawShadow(path, turnedOn ? _color : Colors.black, 5, true);
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return oldDelegate.turnedOn != turnedOn ||
        oldDelegate.size != size ||
        oldDelegate.image != image;
  }

  @override
  bool? hitTest(Offset position) {
    if (position.dx < 50 && position.dy > size.height - 80) {
      return true;
    }
    return false;
  }
}

// import 'package:flutter/material.dart';
//
// class LinePainter extends CustomPainter {
//   final Offset mousePosition;
//   final Offset startingPosition;
//
//   LinePainter({
//     required this.mousePosition,
//     required this.startingPosition,
//   });
//   @override
//   void paint(Canvas canvas, Size size) {
//     final path = Path();
//     final paint = Paint();
//     paint.color = Colors.white;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 2;
//     path.moveTo(startingPosition.dx, startingPosition.dy);
//     Offset endpoint = _calculateMidpoint(startingPosition, mousePosition, size);
//     path.lineTo(endpoint.dx, endpoint.dy);
//     endpoint = _calculateEndpoint(endpoint, size);
//     path.lineTo(endpoint.dx, endpoint.dy);
//     canvas.drawPath(path, paint);
//   }
//
//   Offset _calculateEndpoint(Offset midpoint, Size size) {
//     double x = midpoint.dx;
//     double y = midpoint.dy;
//     Offset temp = midpoint;
//     while (x < size.width && x > 0 && y < size.height && y > 0) {
//       temp = _calculateMidpoint(mousePosition, midpoint, size);
//     }
//     return temp;
//   }
//
//   Offset _calculateMidpoint(Offset p1, Offset m, Size size) {
//     // FROM FORMULA: mx = (x1 + x2) / 2
//     // FROM FORMULA: my = (y1 + y2) / 2
//     double x2 = (2 * m.dx) - p1.dx;
//     double y2 = (2 * m.dy) - p1.dy;
//     return Offset(x2, y2);
//   }
//
//   @override
//   bool shouldRepaint(covariant LinePainter oldDelegate) {
//     return true;
//   }
// }
