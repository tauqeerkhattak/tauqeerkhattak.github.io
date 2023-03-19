import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class AnimatedBoxes extends StatefulWidget {
  const AnimatedBoxes({Key? key}) : super(key: key);

  @override
  State<AnimatedBoxes> createState() => _AnimatedBoxesState();
}

class _AnimatedBoxesState extends State<AnimatedBoxes>
    with TickerProviderStateMixin {
  late int numberOfBoxes;
  final random = math.Random();
  late AnimationController _firstController;
  late AnimationController _secondController;
  late Animation<double> _firstAnimation;
  late Animation<double> _secondAnimation;

  @override
  void initState() {
    super.initState();
    window.onKeyData = (final keyData) {
      if (keyData.logical == LogicalKeyboardKey.escape.keyId &&
          keyData.type == KeyEventType.up) {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
        return false;
      }
      return false;
    };
    final nextInt = random.nextInt(100);
    numberOfBoxes =
        nextInt.isEven ? AppColors.purple.length : AppColors.paleBlue.length;
    _firstController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _secondController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _firstAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_firstController);
    _secondAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_secondController);
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ...List.generate(
            numberOfBoxes,
            (index) {
              return _box(
                index: index,
                purpleOrBlue: numberOfBoxes == AppColors.purple.length,
              );
            },
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Press escape to go back',
              style: GoogleFonts.pressStart2p(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _box({required int index, required bool purpleOrBlue}) {
    final i = numberOfBoxes - index;
    final size = MediaQuery.of(context).size.height * (i / 11);
    log('Size: $size');
    return Center(
      child: AnimatedBuilder(
        animation: index % 2 == 0 ? _secondAnimation : _firstAnimation,
        builder: (context, child) {
          final animationValue =
              index % 2 == 0 ? _secondAnimation.value : _firstAnimation.value;
          final radius = BorderRadius.circular(40 * animationValue);
          return PhysicalModel(
            color: purpleOrBlue
                ? AppColors.purple[index]
                : AppColors.paleBlue[index],
            elevation: 10.0,
            borderRadius: radius,
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: purpleOrBlue
                    ? AppColors.purple[index]
                    : AppColors.paleBlue[index],
                borderRadius: radius,
              ),
            ),
          );
        },
      ),
    );
  }
}
