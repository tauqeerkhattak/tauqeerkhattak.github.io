import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class StalkingBoxes extends StatefulWidget {
  const StalkingBoxes({Key? key}) : super(key: key);

  @override
  State<StalkingBoxes> createState() => _StalkingBoxesState();
}

class _StalkingBoxesState extends State<StalkingBoxes> {
  final StreamController<Offset> _positionController = StreamController();
  final _focusNode = FocusNode();

  Widget _getBox({
    required double size,
    required int milliseconds,
    required Color color,
    required Offset position,
  }) {
    return AnimatedPositioned(
      duration: Duration(
        milliseconds: milliseconds,
      ),
      top: (position.dy) - (size / 2),
      left: (position.dx) - (size / 2),
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
    // window.onKeyData = (final keyData) {
    //   if (keyData.logical == LogicalKeyboardKey.escape.keyId &&
    //       keyData.type == KeyEventType.up) {
    //     Navigator.of(context).pop();
    //     return true;
    //   }
    //   return false;
    // };
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
  }

  void onKeyPressed(RawKeyEvent keyEvent) {
    print('Pressedddd');
    if (keyEvent.logicalKey == LogicalKeyboardKey.escape) {
      log('Pressed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: onKeyPressed,
        child: MouseRegion(
          cursor: SystemMouseCursors.none,
          onHover: (event) {
            _positionController.add(event.position);
          },
          child: StreamBuilder<Offset>(
            stream: _positionController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _getStalkingBoxes(
                  position: snapshot.data!,
                );
              } else {
                return _getStaticBoxes();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getStalkingBoxes({
    required Offset position,
  }) {
    return Stack(
      children: [
        ...List.generate(
          10,
          (index) {
            final size = MediaQuery.of(context).size.width * ((index + 1) / 40);
            final duration = 800 * ((index * 1) / 10);
            return _getBox(
              size: size,
              milliseconds: duration.toInt(),
              color: AppColors.boxColors.reversed.toList()[index],
              position: position,
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
    );
  }

  Widget _getStaticBoxes() {
    final size = MediaQuery.of(context).size;
    final centerOffset = Offset(size.width / 2, size.height / 2);
    return Stack(
      children: [
        ...List.generate(
          10,
          (index) {
            final size = MediaQuery.of(context).size.width * ((index + 1) / 40);
            final duration = 800 * ((index * 1) / 10);
            return _getBox(
              size: size,
              milliseconds: duration.toInt(),
              color: AppColors.boxColors.reversed.toList()[index],
              position: centerOffset,
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
    );
  }
}
