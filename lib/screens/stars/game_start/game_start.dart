import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../game_page/game_page.dart';

class GameStart extends StatelessWidget {
  const GameStart({
    Key? key,
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
            _text('Welcome!'),
            const SizedBox(
              height: 120,
            ),
            GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GamePage(),
                  ),
                  (route) => false),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100,
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
        fontSize: size ?? 40,
        color: Colors.white,
      ),
    );
  }
}
