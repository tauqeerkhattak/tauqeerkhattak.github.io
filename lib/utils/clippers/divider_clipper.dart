import 'package:flutter/cupertino.dart';

class DividerClipper extends CustomClipper<Rect> {
  final double ratio;

  DividerClipper({required this.ratio});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      0,
      0,
      size.width * ratio,
      size.height,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return oldClipper != this;
  }
}
