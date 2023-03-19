import 'package:flutter/material.dart';

class ClipService extends CustomClipper<RRect> {
  final Offset center;
  final double? width;

  ClipService({
    required this.center,
    this.width,
  });

  @override
  RRect getClip(Size size) {
    // Path path = Path();
    // path.addRect(
    //   ,
    // );
    final rect = Rect.fromCenter(
      center: center,
      width: width ?? 250,
      height: 150,
    );
    return RRect.fromRectAndRadius(rect, const Radius.circular(10));
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return false;
  }
}
