import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../home.dart';

class StalkingBoxes extends StatefulWidget {
  const StalkingBoxes({Key? key}) : super(key: key);

  @override
  State<StalkingBoxes> createState() => _StalkingBoxesState();
}

class _StalkingBoxesState extends State<StalkingBoxes> {
  final StreamController<Offset> _positionController = StreamController();
  Offset? _position;

  Widget _getBox({
    required double size,
    required int milliseconds,
    required Color color,
  }) {
    return AnimatedPositioned(
      duration: Duration(
        milliseconds: milliseconds,
      ),
      top: (_position?.dy ?? 0) - (size / 2),
      left: (_position?.dx ?? 0) - (size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    window.onKeyData = (final keyData) {
      if (keyData.logical == LogicalKeyboardKey.escape.keyId) {
        log('Escape pressed!');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Home();
            },
          ),
          (route) => false,
        );
        return true;
      }
      return false;
    };
    _positionController.stream.listen((event) {
      _position = event;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: (event) {
          _positionController.add(event.position);
        },
        child: Center(
          child: Stack(
            children: [

              ...List.generate(
                10,
                (index) {
                  final size =
                      MediaQuery.of(context).size.width * ((index + 1) / 40);
                  final duration = 800 * ((index * 1) / 10);
                  return _getBox(
                    size: size,
                    milliseconds: duration.toInt(),
                    color: AppColors.boxColors.reversed.toList()[index],
                  );
                },
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  'Press escape to go back',
                  style: GoogleFonts.pressStart2p(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
