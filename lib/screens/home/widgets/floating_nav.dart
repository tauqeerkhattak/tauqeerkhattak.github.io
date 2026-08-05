import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FloatingNav extends StatelessWidget {
  final VoidCallback onRoomLightToggle;
  final bool isRoomLightOn;
  final Function(String) onNavTap;

  const FloatingNav({
    super.key,
    required this.onRoomLightToggle,
    required this.isRoomLightOn,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? Colors.grey[900]!.withValues(alpha: 0.8)
        : Colors.white.withValues(alpha: 0.8);
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: textColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNavItem('HOME', textColor),
          _buildNavItem('EXPERIENCE', textColor),
          _buildNavItem('PROJECTS', textColor),
          _buildNavItem('CONNECT', textColor),
          const SizedBox(width: 10),
          VerticalDivider(
              color: textColor.withValues(alpha: 0.2),
              width: 1,
              indent: 5,
              endIndent: 5),
          const SizedBox(width: 10),
          IconButton(
            onPressed: onRoomLightToggle,
            icon: Icon(
              isRoomLightOn ? Icons.lightbulb : Icons.lightbulb_outline,
              color: isRoomLightOn ? Colors.yellow : textColor,
            ),
            tooltip: 'Toggle Room Light',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, Color color) {
    return TextButton(
      onPressed: () => onNavTap(label),
      child: Text(
        label,
        style: GoogleFonts.sora(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
