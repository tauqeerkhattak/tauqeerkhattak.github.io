import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../models/obstacles/obstacle_data.dart';
import '../../../utils/assets.dart';
import '../game_over/game_over.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _obstacleController;
  final random = Random();
  final int numberOfStars = 50;
  final _slideDuration = const Duration(
    seconds: 10,
  );
  final _scaleDuration = const Duration(
    milliseconds: 2000,
  );
  StreamController<Offset> controller = StreamController<Offset>();
  StreamController<int> scoreController = StreamController<int>();
  int score = 0;
  ObstacleData? obstacleData;
  GlobalKey rocketKey = GlobalKey();
  GlobalKey obstacleKey = GlobalKey();

  double getLeftPosition({
    required double width,
    required double x,
    required double animationValue,
  }) {
    if (animationValue <= 0.0) {
      return x;
    } else {
      final position = x + (width * animationValue);
      if (position >= width) {
        return position - width;
      } else {
        return position;
      }
    }
  }

  double _getObstacleXPosition({required double width}) {
    final animationValue = _obstacleController.value;
    final position = 1.5 * width * animationValue;
    if (animationValue <= 0.0) {
      return 0;
    } else if (animationValue >= width) {
      return width;
    } else {
      return position;
    }
  }

  double _getObstacleYPosition(
      {required double height, required double width}) {
    final animationValue = _obstacleController.value;
    final rocketSize = width * 0.1;
    if (animationValue >= 0.99) {
      final nextHeight = random.nextInt(height.floor()).toDouble();
      final nextSpeed = random.nextInt(5);
      final nextImage = random.nextInt(Assets.obstacles.length);
      obstacleData = obstacleData?.copyWith(
        yPosition: nextHeight,
        speed: nextSpeed > 0 ? Duration(seconds: nextSpeed) : null,
        image: Assets.obstacles[nextImage],
      );
      _obstacleController.duration = obstacleData!.speed;
      _obstacleController.forward(from: 0.0);
      score += 1;
      scoreController.add(score);
    }
    if (obstacleData!.yPosition! + rocketSize >= height) {
      return obstacleData!.yPosition! - (width * 0.1);
    } else if (obstacleData!.yPosition! + rocketSize <= 0.0) {
      return obstacleData!.yPosition! + (width * 0.1);
    } else {
      return obstacleData!.yPosition!;
    }
  }

  double getScaleValue({
    required int index,
  }) {
    if (index % 2 == 0) {
      return _scaleController.value;
    } else {
      return 1 - _scaleController.value;
    }
  }

  void _gameOver() {
    _obstacleController.stop();
    _slideController.stop();
    _scaleController.stop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameOver(
            score: score,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: _slideDuration,
    )..repeat(
        reverse: false,
        min: 0.0,
        max: 1.0,
      );
    _scaleController = AnimationController(
      vsync: this,
      duration: _scaleDuration,
    )..repeat(
        reverse: true,
      );
    _obstacleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );
    Future.delayed(const Duration(seconds: 2), () {
      _obstacleController.repeat(
        reverse: false,
        min: 0.0,
        max: 1.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    obstacleData = obstacleData = ObstacleData(
      image: Assets.rock,
      speed: const Duration(seconds: 12),
      yPosition: MediaQuery.of(context).size.height * 0.5,
    );
    return Scaffold(
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: (event) {
          controller.add(event.position);
        },
        child: Stack(
          children: [
            _buildBackground(),
            ..._buildStars(context),
            _buildObstacles(),
            _buildRocket(),
            _buildScore(),
          ],
        ),
      ),
    );
  }

  void _checkCollision() {
    try {
      final box1 = rocketKey.currentContext?.findRenderObject() as RenderBox?;
      final box2 = obstacleKey.currentContext?.findRenderObject() as RenderBox?;

      final size1 = box1?.size;
      final size2 = box2?.size;

      final position1 = box1?.localToGlobal(Offset.zero);
      final position2 = box2?.localToGlobal(Offset.zero);

      if (position1 != null &&
          position2 != null &&
          size1 != null &&
          size2 != null) {
        final collide = (position1.dx < position2.dx + size2.width &&
            position1.dx + size1.width > position2.dx &&
            position1.dy < position2.dy + size2.height &&
            position1.dy + size1.height > position2.dy);

        if (collide) {
          _gameOver();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
    }
  }

  Widget _buildScore() {
    return Positioned(
      top: 10,
      right: 10,
      child: StreamBuilder(
        stream: scoreController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              'SCORE: ${snapshot.data}',
              style: GoogleFonts.pressStart2p(
                fontWeight: FontWeight.w400,
                fontSize: 25,
                color: Colors.white,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildRocket() {
    return StreamBuilder<Offset>(
      stream: controller.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Positioned(
            key: rocketKey,
            left: snapshot.data!.dx,
            top: snapshot.data!.dy,
            child: Transform.rotate(
              angle: -pi / 2,
              child: Lottie.asset(
                'assets/lottie/rocket.json',
                fit: BoxFit.fitWidth,
                width: 60,
                height: 60,
                repeat: true,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
    );
  }

  List<Widget> _buildStars(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List<Widget> stars = List.generate(
      numberOfStars,
      (index) {
        final xPosition = random.nextInt(width.toInt()).toDouble();
        final yPosition = random.nextInt(height.toInt()).toDouble();
        return AnimatedBuilder(
          animation: _slideController,
          builder: (
            context,
            child,
          ) {
            return Positioned(
              left: getLeftPosition(
                x: xPosition,
                width: width,
                animationValue: _slideController.value,
              ),
              top: yPosition,
              child: AnimatedBuilder(
                animation: _scaleController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: getScaleValue(index: index),
                    child: child!,
                  );
                },
                child: child!,
              ),
            );
          },
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: kElevationToShadow[1],
            ),
          ),
        );
      },
    );
    return stars;
  }

  Widget _buildObstacles() {
    final size = MediaQuery.of(context).size;
    double top = random.nextInt(size.height.floor()).toDouble();
    final rockSize = size.width * 0.1;
    if (top > (size.width - rockSize)) {
      top -= rockSize;
    }
    return AnimatedBuilder(
      key: obstacleKey,
      animation: _obstacleController,
      builder: (context, child) {
        _checkCollision();
        return Positioned(
          left: _getObstacleXPosition(
            width: size.width,
          ),
          top: _getObstacleYPosition(
            height: size.height,
            width: size.width,
          ),
          child: Transform.rotate(
            angle: 2 * pi * _obstacleController.value,
            child: Image.asset(
              obstacleData!.image!,
              width: rockSize,
              height: rockSize,
            ),
          ),
        );
      },
    );
  }
}
