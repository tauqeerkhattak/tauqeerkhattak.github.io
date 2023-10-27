import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/app_colors.dart';
import '../../utils/painters/clock_paints/circle_painter.dart';
import '../../utils/painters/clock_paints/hours_painter.dart';
import '../../utils/painters/clock_paints/minute_painter.dart';
import '../../utils/painters/clock_paints/seconds_painter.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> with TickerProviderStateMixin {
  StreamController<DateTime> timeStream = StreamController();
  late AnimationController _secondAnimation;
  late AnimationController _minuteAnimation;
  late AnimationController _hourAnimation;
  final _oneSecond = const Duration(seconds: 1);
  final _oneMinute = const Duration(seconds: 60);
  final _oneHour = const Duration(hours: 1);
  final _oneDay = const Duration(days: 1);
  Timer? _timer;
  bool shouldAdd = true;
  final _focusNode = FocusNode();

  void initialize() {
    _secondAnimation = AnimationController(
      vsync: this,
      duration: _oneMinute,
      upperBound: 60,
    );
    _minuteAnimation = AnimationController(
      vsync: this,
      duration: _oneHour,
      lowerBound: 0,
      upperBound: 59,
    );
    _hourAnimation = AnimationController(
      vsync: this,
      duration: _oneDay,
      lowerBound: 0,
      upperBound: 23,
    );
    _timer = Timer.periodic(
      _oneSecond,
      (timer) {
        final now = DateTime.now();
        if (now.second == 0) {
          shouldAdd = false;
          _secondAnimation.forward(from: 0.0);
        }
        if (now.minute == 59) {
          _minuteAnimation.forward(from: 0.0);
        }
        if (_hourAnimation.isCompleted) {
          _hourAnimation.forward(from: 0.0);
        }
        timeStream.add(now);
      },
    );
    final now = DateTime.now();
    final seconds = now.second + (now.millisecond / 1000);
    final minutes = now.minute + (seconds / 60);
    final hours = now.hour + (minutes / 60);
    _secondAnimation.forward(from: seconds);
    _minuteAnimation.forward(from: minutes);
    _hourAnimation.forward(from: hours);
  }

  void onKeyPressed(RawKeyEvent keyEvent) {
    if (keyEvent.logicalKey == LogicalKeyboardKey.escape) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _focusNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    _secondAnimation.dispose();
    _minuteAnimation.dispose();
    _hourAnimation.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: RawKeyboardListener(
          focusNode: _focusNode,
          onKey: onKeyPressed,
          child: _buildBody(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        'Press escape to go back',
        style: GoogleFonts.pressStart2p(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      leadingWidth: 0.0,
    );
  }

  Widget _buildBody() {
    return Row(
      children: [
        Expanded(
          child: _buildAnalogClock(),
        ),
        Expanded(
          child: _buildDigitalClock(),
        ),
      ],
    );
  }

  Widget _buildAnalogClock() {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: CirclePainter(),
          size: Size(
            size.height * 0.7,
            size.height * 0.7,
          ),
        ),
        AnimatedBuilder(
          animation: _secondAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: SecondsPainter(
                value: _secondAnimation.value,
              ),
              size: Size(
                size.height * 0.7,
                size.height * 0.7,
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _minuteAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: MinutePainter(
                value: _minuteAnimation.value,
              ),
              size: Size(
                size.height * 0.7,
                size.height * 0.7,
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _hourAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: HoursPainter(
                value: _hourAnimation.value,
              ),
              size: Size(
                size.height * 0.7,
                size.height * 0.7,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDigitalClock() {
    return StreamBuilder<DateTime>(
      stream: timeStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DateTime now = snapshot.data!;
          if (shouldAdd) {
            log('Added: $now');
            now = now.add(_oneSecond);
          }
          final formattedTime = DateFormat('HH:mm:ss').format(now);
          return Center(
            child: _text(
              formattedTime,
            ),
          );
        } else {
          final now = DateTime.now();
          final formattedTime = DateFormat('hh:mm:ss').format(now);
          return Center(
            child: _text(
              formattedTime,
            ),
          );
        }
      },
    );
  }

  Widget _text(String text) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.actor(
          fontSize: 150,
          fontWeight: FontWeight.bold,
          color: AppColors.silver,
        ),
        // style: G,
      ),
    );
  }
}
