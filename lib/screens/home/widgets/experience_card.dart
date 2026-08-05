import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tauqeer_portfolio/utils/context_utils.dart';

class ExperienceCard extends StatelessWidget {
  final Map<String, dynamic> experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience['role'],
                      style: GoogleFonts.sora(
                        fontSize:
                            context.when(desktop: 22, tablet: 20, mobile: 18),
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    Text(
                      experience['company'],
                      style: GoogleFonts.sora(
                        fontSize:
                            context.when(desktop: 18, tablet: 16, mobile: 14),
                        fontWeight: FontWeight.w400,
                        color: color.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                experience['period'],
                style: GoogleFonts.sora(
                  fontSize: context.when(desktop: 16, tablet: 14, mobile: 12),
                  fontWeight: FontWeight.w300,
                  color: color.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...(experience['points'] as List<String>).map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        point,
                        style: GoogleFonts.sourceCodePro(
                          fontSize:
                              context.when(desktop: 16, tablet: 14, mobile: 14),
                          color: color.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
