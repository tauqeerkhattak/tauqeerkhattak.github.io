import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_practice/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Load style to avoid the lag in Texts.
  final style = GoogleFonts.pressStart2p();
  final style1 = GoogleFonts.sourceCodePro();
  runApp(const WebPractice());
}

class WebPractice extends StatelessWidget {
  const WebPractice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tauqeer Ahmed',
      home: Home(),
    );
  }
}
