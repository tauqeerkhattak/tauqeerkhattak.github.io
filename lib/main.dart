import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'firebase_options.dart';
import 'screens/beenit/beenit_deletion_steps.dart';
import 'screens/beenit/privacy_policy.dart';
import 'screens/home/home.dart';

final themeNotifier = ValueNotifier<Brightness>(Brightness.dark);
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    log('Exception: $e');
  }
  runApp(const Portfolio());
}

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          theme: _getThemeData(value),
          darkTheme: _getThemeData(value),
          navigatorKey: navigatorKey,
          title: 'Tauqeer Ahmed',
          routes: {
            '/beenit/deletion-steps': (_) => BeenItDeletionSteps(),
            '/beenit/privacy-policy': (_) => BeenItPrivacyPolicy(),
            '/': (_) => const Home(),
          },
          initialRoute: '/',
          navigatorObservers: [
            FirebaseAnalyticsObserver(
              analytics: FirebaseAnalytics.instance,
            ),
          ],
          builder: (context, child) {
            return ResponsiveBreakpoints(
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
              child: child!,
            );
          },
        );
      },
    );
  }

  ThemeData _getThemeData(Brightness brightness) {
    return ThemeData(
      scaffoldBackgroundColor:
          brightness == Brightness.dark ? Colors.black : Colors.white,
      colorScheme: _getColorScheme(brightness),
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

  ColorScheme _getColorScheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return ColorScheme.fromSeed(
        seedColor: Colors.black,
        brightness: Brightness.dark,
        primary: Colors.black,
        secondary: Colors.black,
      );
    }
    return ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.light,
      primary: Colors.white,
    );
  }
}
