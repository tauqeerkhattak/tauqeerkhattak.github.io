import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:web_practice/screens/half_filled_text/half_filled_text_page.dart';
import 'package:web_practice/screens/home/views/main_design.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = PageController();
  int _currentPage = 0;
  final widgets = [
    const MainDesign(),
    const HalfFilledTexPage(
      text: 'Projects',
    ),
    // Container(
    //   height: SizeConfig.height,
    //   width: SizeConfig.width,
    //   color: Colors.white,
    //   child: const Text(
    //     'Projects',
    //   ),
    // ),
  ];

  Future<void> _animateToPage(int page) async {
    await _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.slowMiddle,
    );
    _currentPage = page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerSignal: (signal) {
          if (signal is PointerScrollEvent) {
            final distanceDegrees = signal.scrollDelta.direction * (180 / pi);
            if (distanceDegrees > 0) {
              if (_currentPage < widgets.length - 1) {
                _animateToPage(_currentPage + 1);
              }
            } else {
              if (_currentPage > 0) {
                _animateToPage(_currentPage - 1);
              }
            }
          }
        },
        child: PageView.builder(
          controller: _controller,
          scrollDirection: Axis.vertical,
          itemCount: widgets.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => widgets[index],
        ),
      ),
    );
  }
}
