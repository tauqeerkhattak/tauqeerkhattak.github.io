import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextShadowPage extends StatefulWidget {
  const TextShadowPage({Key? key}) : super(key: key);

  @override
  State<TextShadowPage> createState() => _TextShadowPageState();
}

class _TextShadowPageState extends State<TextShadowPage> {
  Offset? center;
  Offset? mouseOffset;
  StreamController<Offset> shadowStream = StreamController<Offset>();
  StreamController<Offset> positionStream = StreamController<Offset>();

  void _onHover(PointerEvent event) {
    final offsetFromTopLeft = event.position;
    positionStream.add(offsetFromTopLeft);
    if (center == null) {
      final size = MediaQuery.of(context).size;
      final centerSize = size / 2;
      center = Offset(centerSize.width, centerSize.height);
    }
    double shadowX = 0;
    double shadowY = 0;
    final diff = offsetFromTopLeft - center!;
    final absX = diff.dx;
    final absY = diff.dy;
    if (absX < 0) {
      shadowX = (absX / 10).abs();
    } else {
      shadowX = -(absX / 10);
    }
    if (absY < 0) {
      if (absY < -100) {
        shadowY = 10;
      } else {
        shadowY = (absY / 10).abs();
      }
    } else if (absY > 100) {
      shadowY = -10;
    } else {
      shadowY = -(absY / 10);
    }
    shadowStream.add(Offset(shadowX, shadowY));
  }

  @override
  void initState() {
    super.initState();
    window.onKeyData = (final keyData) {
      if (keyData.logical == LogicalKeyboardKey.escape.keyId &&
          keyData.type == KeyEventType.up) {
        Navigator.of(context).pop();
        return true;
      }
      return false;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: _onHover,
      child: StreamBuilder<Offset>(
        stream: positionStream.stream,
        builder: (context, snapshot) {
          return Stack(
            children: [
              _buildPointerStream(snapshot.data),
              _buildTextStream(),
              _buildBackText(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackText() {
    return Positioned(
      top: 20,
      left: 20,
      child: Text(
        'Press escape to go back',
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPointerStream(Offset? position) {
    return Positioned(
      top: position?.dy,
      left: position?.dx,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          boxShadow: List.generate(
            2,
            (index) => const BoxShadow(
              offset: Offset.zero,
              blurRadius: 100.0,
              spreadRadius: 10.0,
              color: Colors.white,
            ),
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildTextStream() {
    return StreamBuilder<Offset>(
      stream: shadowStream.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _buildText(Offset.zero);
        }
        return _buildText(snapshot.data!);
      },
    );
  }

  Widget _buildText(Offset offset) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: List.generate(
                2,
                (index) => BoxShadow(
                  offset: offset,
                  blurRadius: 100.0,
                  spreadRadius: 10.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            'Tauqeer'.toUpperCase(),
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 100,
              letterSpacing: 10.0,
            ),
          ),
        ),
      ],
    );
  }
}
