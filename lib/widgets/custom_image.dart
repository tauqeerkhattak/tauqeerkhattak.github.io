import 'package:flutter/material.dart';
import 'package:web_practice/services/clip_service.dart';
import 'package:web_practice/services/paint_service.dart';
import 'package:web_practice/utils/assets.dart';
import 'package:web_practice/utils/size_config.dart';

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
    return CustomPaint(
      painter: PaintService(
        center: center,
        width: width,
      ),
      child: ClipPath(
        clipper: ClipService(
          center: center,
          width: width,
        ),
        child: InkWell(
          onTap: onTap,
          onHover: onHover,
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
