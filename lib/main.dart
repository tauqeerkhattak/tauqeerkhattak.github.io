import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:web_practice/screens/home/home.dart';
import 'package:web_practice/services/locator.dart';

import 'utils/assets.dart';
import 'utils/size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const WebPractice());
}

class WebPractice extends StatelessWidget {
  const WebPractice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    for (final image in Assets.images) {
      precacheImage(AssetImage(image), context);
    }
    return MaterialApp(
      theme: _getThemeData(),
      title: 'Tauqeer Ahmed',
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
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
