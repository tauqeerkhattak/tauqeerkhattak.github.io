import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../utils/assets.dart';
import '../../utils/painters/line_painter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double angle = 0;
  ui.Image? _image;
  bool _lightSwitch = true;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    try {
      final data = await rootBundle.load(Assets.light);
      _image = await decodeImageFromList(data.buffer.asUint8List());
      setState(() {});
    } catch (e) {
      log('Exception: $e');
    }
  }

  void _calculateAngle(Offset position) {
    // Applying law of cosines to find angle between mouse position and lamp
    // starting point.
    final screenSize = MediaQuery.sizeOf(context);
    final angle = calculateAngleAtB(
      screenSize.height,
      position.dx,
      position.dy,
    );
    if (!angle.isNaN) {
      setState(() {
        this.angle = angle;
      });
    }
    return;
    // final aPoint = Offset.zero;
    // final bPoint = Offset(0, -screenSize.height);
    // final cPoint = position;
    //
    // // Calculate Edge a:
    // final x1 =
    //     pow(cPoint.dx - bPoint.dx, 2) + pow((-cPoint.dy) - (-bPoint.dy), 2);
    // final edgeA = math.sqrt(x1);
    //
    // // Calculate Edge b:
    // final x2 =
    //     pow(cPoint.dx - aPoint.dx, 2) + pow((-cPoint.dy) - (-aPoint.dy), 2);
    // final edgeB = math.sqrt(x2);
    //
    // // Calculate Edge c:
    // // No need to calculate edge c as it will be equal to screen height.
    // final edgeC = screenSize.height;
    //
    // // Calculate angle between edgeC and edgeB
    // final upper = pow(edgeA, 2) + pow(edgeC, 2) - pow(edgeB, 2);
    // final lower = 2 * edgeA * edgeC;
    // final newAngle = acos(upper / lower);
    // if (!newAngle.isNaN) {
    //   this.angle = newAngle;
    //   _mouseOffset = position;
    //   setState(() {});
    // }
  }

  double calculateAngleAtB(double screenHeight, double mouseX, double mouseY) {
    // Vectors
    double BAx = 0;
    double BAy = -screenHeight;
    double BCx = mouseX;
    double BCy = mouseY - screenHeight;

    // Dot product
    double dotProduct = (BAx * BCx) + (BAy * BCy);

    // Magnitudes
    double magnitudeBA = math.sqrt(BAx * BAx + BAy * BAy);
    double magnitudeBC = math.sqrt(BCx * BCx + BCy * BCy);

    // Cosine of the angle
    double cosTheta = dotProduct / (magnitudeBA * magnitudeBC);

    // Angle in radians
    double angleInRadians = math.acos(cosTheta);

    // Convert to degrees
    return angleInRadians;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: color,
      body: MouseRegion(
        onHover: (event) => _calculateAngle(event.position),
        child: _buildBody(color),
      ),
    );
  }

  Widget _buildBody(Color color) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        _buildFlashLight(size),
        _buildContent(color),
        _buildThemeButton(color),
      ],
    );
  }

  _buildContent(ui.Color color) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: AutoSizeText(
              'TAUQEER',
              stepGranularity: 1,
              maxFontSize: 100,
              minFontSize: 30,
              style: GoogleFonts.sora(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 100,
                shadows: [
                  Shadow(
                    color: color.withOpacity(0.8),
                    blurRadius: 5,
                    offset: Offset(5, 5),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Transform _buildFlashLight(ui.Size size) {
    final theme = Theme.of(context).brightness;
    return Transform.rotate(
      angle: angle,
      alignment: Alignment.bottomLeft,
      origin: Offset.zero,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _lightSwitch = !_lightSwitch;
          });
        },
        child: CustomPaint(
          painter: LinePainter(
            turnedOn: _lightSwitch,
            image: _image,
            isDark: theme == ui.Brightness.dark,
            size: size,
          ),
          size: size,
        ),
      ),
    );
  }

  Widget _buildThemeButton(Color color) {
    final isDark = Theme.of(context).brightness == ui.Brightness.dark;
    return Positioned(
      right: 10,
      top: 10,
      child: IconButton(
        onPressed: () {
          if (isDark) {
            themeNotifier.value = ui.Brightness.light;
          } else {
            themeNotifier.value = ui.Brightness.dark;
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 10,
        ),
        icon: Icon(
          isDark ? Icons.light_mode : Icons.dark_mode,
          size: 30,
          color: color,
        ),
      ),
    );
  }
}
