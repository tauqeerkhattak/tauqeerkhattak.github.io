import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tauqeer_portfolio/utils/context_utils.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.when(desktop: 40, tablet: 30, mobile: 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.sora(
              fontSize: context.when(desktop: 40, tablet: 30, mobile: 24),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Container(
            height: 4,
            width: 60,
            color: color.withValues(alpha: 0.3),
            margin: const EdgeInsets.only(top: 8),
          ),
        ],
      ),
    );
  }
}
