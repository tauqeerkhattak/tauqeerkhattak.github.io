import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_practice/utils/assets.dart';

class AnimatedTechnologies extends StatefulWidget {
  final Color textColor;
  const AnimatedTechnologies({
    super.key,
    required this.textColor,
  });

  @override
  State<AnimatedTechnologies> createState() => _AnimatedTechnologiesState();
}

class _AnimatedTechnologiesState extends State<AnimatedTechnologies>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 7,
      duration: const Duration(seconds: 15),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutoSizeText(
          'Tech that I work on: ',
          maxLines: 1,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: widget.textColor,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final value = _controller.value.floor();
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              child: SvgPicture.asset(
                Assets.technologies[value],
                width: 100,
                height: 100,
              ),
            );
          },
        ),
      ],
    );
  }
}
