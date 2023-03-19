import 'package:flutter/material.dart';
import 'package:web_practice/services/clip_service.dart';

import '../utils/assets.dart';
import '../utils/size_config.dart';

class CustomImage extends StatelessWidget {
  final Function(bool) onHover;
  final VoidCallback onTap;
  final int imageNo;
  final Offset center;
  final double? width;

  const CustomImage({
    Key? key,
    required this.onHover,
    required this.onTap,
    required this.imageNo,
    required this.center,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      clipper: ClipService(
        center: center,
        width: width,
      ),
      child: InkWell(
        onTap: onTap,
        onHover: onHover,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: Image.asset(
            Assets.images[imageNo],
            fit: BoxFit.fill,
            height: SizeConfig.height,
            width: SizeConfig.width,
          ),
        ),
      ),
    );
  }
}
