import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_practice/screens/home/painters/line_painter.dart';
import 'package:web_practice/utils/assets.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: (event) => _calculateAngle(event.position),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Transform.rotate(
          angle: angle,
          filterQuality: FilterQuality.high,
          alignment: Alignment.bottomLeft,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _lightSwitch = !_lightSwitch;
              });
            },
            child: CustomPaint(
              willChange: false,
              painter: LinePainter(
                turnedOn: _lightSwitch,
                image: _image,
                size: MediaQuery.sizeOf(context),
              ),
              size: MediaQuery.sizeOf(context),
            ),
          ),
        ),
        Center(
          child: Text(
            'TAUQEER',
            style: GoogleFonts.sora(
              color: Colors.black,
              fontSize: 110,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  blurRadius: 5,
                  offset: Offset(5, 5),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:web_practice/screens/home/painters/line_painter.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   Offset _mousePosition = Offset(100, 100);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: MouseRegion(
//         onHover: (event) {
//           setState(() {
//             _mousePosition = event.position;
//           });
//         },
//         child: _buildBody(),
//       ),
//     );
//   }
//
//   Widget _buildBody() {
//     final size = MediaQuery.sizeOf(context);
//     return SizedBox.fromSize(
//       size: size,
//       child: CustomPaint(
//         painter: LinePainter(
//           startingPosition: Offset(0, size.height),
//           mousePosition: _mousePosition,
//         ),
//         size: size,
//         child: SizedBox.fromSize(
//           size: size,
//         ),
//       ),
//     );
//   }
// }
//
// // import 'dart:math';
// //
// // import 'package:flutter/gestures.dart';
// // import 'package:flutter/material.dart';
// // import 'package:web_practice/screens/half_filled_text/half_filled_text_page.dart';
// // import 'package:web_practice/screens/home/views/main_design.dart';
// //
// // class Home extends StatefulWidget {
// //   const Home({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Home> createState() => _HomeState();
// // }
// //
// // class _HomeState extends State<Home> {
// //   final _controller = PageController();
// //   int _currentPage = 0;
// //   final widgets = [
// //     const MainDesign(),
// //     const HalfFilledTexPage(
// //       text: 'Projects',
// //     ),
// //     // Container(
// //     //   height: SizeConfig.height,
// //     //   width: SizeConfig.width,
// //     //   color: Colors.white,
// //     //   child: const Text(
// //     //     'Projects',
// //     //   ),
// //     // ),
// //   ];
// //
// //   Future<void> _animateToPage(int page) async {
// //     await _controller.animateToPage(
// //       page,
// //       duration: const Duration(milliseconds: 600),
// //       curve: Curves.slowMiddle,
// //     );
// //     _currentPage = page;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Listener(
// //         onPointerSignal: (signal) {
// //           if (signal is PointerScrollEvent) {
// //             final distanceDegrees = signal.scrollDelta.direction * (180 / pi);
// //             if (distanceDegrees > 0) {
// //               if (_currentPage < widgets.length - 1) {
// //                 _animateToPage(_currentPage + 1);
// //               }
// //             } else {
// //               if (_currentPage > 0) {
// //                 _animateToPage(_currentPage - 1);
// //               }
// //             }
// //           }
// //         },
// //         child: PageView.builder(
// //           controller: _controller,
// //           scrollDirection: Axis.vertical,
// //           itemCount: widgets.length,
// //           physics: const NeverScrollableScrollPhysics(),
// //           itemBuilder: (context, index) => widgets[index],
// //         ),
// //       ),
// //     );
// //   }
// // }
