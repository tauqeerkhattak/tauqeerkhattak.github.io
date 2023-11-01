import 'package:flutter/material.dart';

class AppColors {
  static const silver = Color(0xffaaa9ad);
  static const sapphire = Color(0xff2D5DA1);

  static const lightBlack = Color(0xff262626);
  static const darkBlack = Color(0xff2D2D2D);
  static const primaryText = Color(0xffFEFEFE);
  static const dividerColor = Color(0xff4A4A4A);

  static const boxColors = [
    Colors.purple,
    Colors.blue,
    Colors.red,
    Colors.pink,
    Colors.amber,
    Colors.yellow,
    Colors.teal,
    Colors.green,
    Colors.orange,
    Colors.indigo,
  ];

  static final purple = [
    Colors.purple.shade100,
    Colors.purple.shade200,
    Colors.purple.shade300,
    Colors.purple.shade400,
    Colors.purple.shade500,
    Colors.purple.shade600,
    Colors.purple.shade700,
    Colors.purple,
    Colors.purple.shade800,
    Colors.purple.shade900,
  ].reversed.toList();

  static final paleBlue = [
    const Color(0xffAED8E6),
    const Color(0xffBED1DF),
    const Color(0xffCECBD8),
    const Color(0xffDFC4D1),
    const Color(0xffEFBECA),
    const Color(0xffFFB7C3),
  ].reversed.toList();
}
