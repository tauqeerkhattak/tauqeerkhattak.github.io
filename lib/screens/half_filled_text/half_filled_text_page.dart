import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/clippers/divider_clipper.dart';

class HalfFilledTexPage extends StatefulWidget {
  final String? text;
  const HalfFilledTexPage({
    super.key,
    this.text,
  });

  @override
  State<HalfFilledTexPage> createState() => _HalfFilledTexPageState();
}

class _HalfFilledTexPageState extends State<HalfFilledTexPage> {
  double ratio = 0.5;

  void _onHover(PointerHoverEvent event) {
    final offset = event.position;
    final size = MediaQuery.sizeOf(context);
    final ratio = offset.dx / size.width;
    this.ratio = ratio;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      child: Scaffold(
        backgroundColor: AppColors.lightBlack,
        body: Stack(
          children: [
            Container(
              color: AppColors.darkBlack,
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width * ratio,
            ),
            ClipRect(
              clipper: DividerClipper(
                ratio: ratio,
              ),
              child: _buildMainText(false),
            ),
            _buildMainText(true),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    final size = MediaQuery.sizeOf(context);
    return Positioned(
      left: size.width * ratio,
      top: 0,
      bottom: 0,
      child: const Center(
        child: VerticalDivider(
          color: AppColors.dividerColor,
          width: 1,
          thickness: 1,
        ),
      ),
    );
  }

  Widget _buildMainText(bool stroke) {
    return Center(
      child: Text(
        widget.text ?? 'testing',
        style: TextStyle(
          fontSize: 150,
          foreground: Paint()
            ..style = stroke ? PaintingStyle.stroke : PaintingStyle.fill
            ..color = AppColors.primaryText,
          letterSpacing: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
