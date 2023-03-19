import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_practice/screens/home.dart';

import 'utils/assets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WebPractice());
}

class WebPractice extends StatelessWidget {
  const WebPractice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (final image in Assets.images) {
      precacheImage(AssetImage(image), context);
    }
    return MaterialApp(
      theme: _getThemeData(),
      title: 'Tauqeer Ahmed',
      home: const Home(),
    );
  }

  ThemeData _getThemeData() {
    return ThemeData(
      textTheme: TextTheme(
        displayLarge: GoogleFonts.sourceCodePro(
          fontSize: 44,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.sourceCodePro(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        displaySmall: GoogleFonts.sourceCodePro(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        labelSmall: GoogleFonts.sourceCodePro(
          fontWeight: FontWeight.w100,
          fontSize: 18,
        ),
        bodyLarge: GoogleFonts.pressStart2p(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
