import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../game_page/game_page.dart';

class GameOver extends StatelessWidget {
  final int score;
  const GameOver({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _text('Game Over! Your score is $score'),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GamePage(),
                  ),
                  (route) => false),
              child: _text(
                'Play again?',
                20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(String text, [double? size]) {
    return Text(
      text,
      style: GoogleFonts.pressStart2p(
        fontWeight: FontWeight.w200,
        fontSize: size ?? 25,
        color: Colors.white,
      ),
    );
  }
}
