import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

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

  double _getFontSize() {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    if (isMobile) {
      return 34;
    }
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    if (isTablet) {
      return 60;
    }
    return 100;
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

  Center _buildContent(ui.Color color) {
    final isMobile = ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET);
    return Center(
      child: Text(
        'TAUQEER',
        style: GoogleFonts.sora(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: _getFontSize(),
          shadows: [
            Shadow(
              color: color.withOpacity(0.8),
              blurRadius: 5,
              offset: isMobile ? Offset(3, 3) : Offset(5, 5),
            )
          ],
        ),
      ),
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
