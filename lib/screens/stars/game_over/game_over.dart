import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_practice/screens/home.dart';

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
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _playAgainButton(context),
                _homeButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _playAgainButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const GamePage(),
          ),
          (route) => false),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
        ),

        child: _text(
          'Play again?',
          20,
        ),
      ),
    );
  }

  Widget _homeButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
          (route) => false),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: _text(
          'Home',
          20,
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
