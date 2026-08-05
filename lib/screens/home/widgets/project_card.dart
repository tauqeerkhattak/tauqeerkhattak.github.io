import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tauqeer_portfolio/utils/context_utils.dart';

class ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? Colors.white : Colors.black;
    final cardColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.05);

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  project['name'],
                  style: GoogleFonts.sora(
                    fontSize: context.when(desktop: 28, tablet: 24, mobile: 22),
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Icon(Icons.open_in_new,
                  color: color.withValues(alpha: 0.5), size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            project['company'],
            style: GoogleFonts.sora(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: color.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project['description'],
            style: GoogleFonts.sourceCodePro(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: (project['details'] as List<String>)
                .map((detail) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        detail,
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 13,
                          color: color.withValues(alpha: 0.8),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
