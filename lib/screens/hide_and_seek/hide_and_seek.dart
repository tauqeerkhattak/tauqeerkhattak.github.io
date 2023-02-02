import 'dart:math';

import 'package:flutter/material.dart';

class HideAndSeek extends StatefulWidget {
  const HideAndSeek({Key? key}) : super(key: key);

  @override
  State<HideAndSeek> createState() => _HideAndSeekState();
}

class _HideAndSeekState extends State<HideAndSeek> {
  Offset? offset;
  final random = Random();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;
      offset = Offset(size.width / 2, size.height / 2);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBox(),
        ],
      ),
    );
  }

  Widget _buildBox() {
    return AnimatedPositioned(
      duration: const Duration(
        milliseconds: 200,
      ),
      left: offset?.dx,
      top: offset?.dy,
      child: MouseRegion(
        onEnter: _onEnter,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                print('I am clicked!');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: kElevationToShadow[24],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Click me!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onEnter(PointerEvent event) {
    final size = MediaQuery.of(context).size;
    int newDx = random.nextInt(size.width.toInt());
    int newDy = random.nextInt(size.height.toInt());
    bool isPositionInvalid = newDx > size.width - 100 ||
        newDy > size.height - 100 ||
        newDx < 100 ||
        newDy < 100;
    if (isPositionInvalid) {
      return _onEnter(event);
    }
    offset = Offset(newDx.toDouble(), newDy.toDouble());
    setState(() {});
  }
}
