import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tauqeer_portfolio/utils/context_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/assets.dart';
import '../../utils/constants.dart';
import '../../utils/painters/line_painter.dart';
import 'widgets/experience_card.dart';
import 'widgets/floating_nav.dart';
import 'widgets/project_card.dart';
import 'widgets/section_title.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ValueNotifier<double> _angleNotifier = ValueNotifier(0);
  final ValueNotifier<bool> _lightSwitchNotifier = ValueNotifier(true);
  final ValueNotifier<bool> _roomLightNotifier = ValueNotifier(false);
  ui.Image? _image;
  final _analytics = FirebaseAnalytics.instance;
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _connectKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final data = await rootBundle.load(Assets.light);
      _image = await decodeImageFromList(data.buffer.asUint8List());
      setState(() {});
      await _saveAnalyticsData();
    } catch (e) {
      log('Exception: $e');
    }
  }

  void _calculateAngle(Offset position) {
    final screenSize = MediaQuery.sizeOf(context);
    final angle = _calculateAngleAtB(
      screenSize.height,
      position.dx,
      position.dy,
    );
    if (!angle.isNaN) {
      _angleNotifier.value = angle;
    }
  }

  double _calculateAngleAtB(double screenHeight, double mouseX, double mouseY) {
    // Pivot is bottom-left (0, screenHeight)
    // We want the angle from the Up vector (0, -1)
    // Using atan2(x, y) where x is horizontal offset and y is vertical offset (Up)
    return math.atan2(mouseX, screenHeight - mouseY);
  }

  Future<void> _saveAnalyticsData() async {
    final name = ResponsiveBreakpoints.of(context).breakpoint.name;
    await _analytics.logEvent(
      name: 'ScreenSizeEvent',
      parameters: {'sizeName': name ?? ''},
    );
  }

  void _scrollToSection(String label) {
    GlobalKey key;
    switch (label) {
      case 'HOME':
        key = _homeKey;
        break;
      case 'EXPERIENCE':
        key = _experienceKey;
        break;
      case 'PROJECTS':
        key = _projectsKey;
        break;
      case 'CONNECT':
        key = _connectKey;
        break;
      default:
        return;
    }

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: color,
      body: MouseRegion(
        onHover: (event) => _calculateAngle(event.position),
        child: Stack(
          children: [
            RepaintBoundary(child: _buildMainContent(color)),
            _buildFloatingNavigation(),
            _buildFlashLightOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(Color color) {
    final horizontalPadding = context.when(
      desktop: MediaQuery.sizeOf(context).width * 0.2,
      tablet: 50.0,
      mobile: 20.0,
    );

    return ListView(
      controller: _scrollController,
      children: [
        _buildHeroSection(color, key: _homeKey),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummarySection(color),
              _buildExperienceSection(color, key: _experienceKey),
              _buildProjectsSection(color, key: _projectsKey),
              _buildEducationSection(color),
              _buildFooter(color, key: _connectKey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlashLightOverlay() {
    final size = MediaQuery.sizeOf(context);
    final isDark = Theme.of(context).brightness == ui.Brightness.dark;

    return IgnorePointer(
      child: ListenableBuilder(
        listenable: Listenable.merge([
          _angleNotifier,
          _lightSwitchNotifier,
          _roomLightNotifier,
        ]),
        builder: (context, child) {
          return RepaintBoundary(
            child: CustomPaint(
              painter: LinePainter(
                turnedOn: _lightSwitchNotifier.value,
                screenSize: size,
                isDark: isDark,
                angle: _angleNotifier.value,
                roomLight: _roomLightNotifier.value,
                image: _image,
              ),
              size: size,
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingNavigation() {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: _roomLightNotifier,
          builder: (context, roomLight, child) {
            return FloatingNav(
              isRoomLightOn: roomLight,
              onRoomLightToggle: () {
                _roomLightNotifier.value = !_roomLightNotifier.value;
              },
              onNavTap: _scrollToSection,
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroSection(Color color, {Key? key}) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      key: key,
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: _buildHeroContent(color),
    );
  }

  Widget _buildHeroContent(ui.Color color) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'TAUQEER',
          style: GoogleFonts.sora(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: context.when(desktop: 100, tablet: 60, mobile: 34),
          ),
        ),
        const SizedBox(height: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () =>
                launchUrl(Uri.parse('https://github.com/tauqeerkhattak')),
            child: Text(
              '<github.com/tauqeerkhattak/>',
              style: GoogleFonts.sora(
                color: textColor.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
                fontSize: context.when(desktop: 24, tablet: 20, mobile: 16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            _lightSwitchNotifier.value = !_lightSwitchNotifier.value;
          },
          child: ValueListenableBuilder(
            valueListenable: _lightSwitchNotifier,
            builder: (context, lightOn, child) {
              return Icon(
                lightOn ? Icons.flashlight_on : Icons.flashlight_off,
                color: textColor,
                size: 40,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(Color color) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'SUMMARY'),
        Text(
          Constants.summary,
          style: GoogleFonts.sourceCodePro(
            fontSize: context.when(desktop: 18, tablet: 16, mobile: 15),
            height: 1.6,
            color: textColor.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 15,
          runSpacing: 10,
          children:
              Assets.technologies.map((tech) => _buildTechChip(tech)).toList(),
        ),
      ],
    );
  }

  Widget _buildTechChip(String techAsset) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        border: Border.all(color: color.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        techAsset.split('/').last.split('.').first.toUpperCase(),
        style: GoogleFonts.sourceCodePro(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildExperienceSection(Color color, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'EXPERIENCE'),
        ...Constants.experiences.map((exp) => ExperienceCard(experience: exp)),
      ],
    );
  }

  Widget _buildProjectsSection(Color color, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'PROJECTS'),
        ...Constants.projects.map((project) => ProjectCard(project: project)),
      ],
    );
  }

  Widget _buildEducationSection(Color color) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'EDUCATION'),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: textColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            Constants.education,
            style: GoogleFonts.sourceCodePro(
              fontSize: context.when(desktop: 18, tablet: 16, mobile: 15),
              height: 1.8,
              color: textColor.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(Color color, {Key? key}) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Center(
        child: Column(
          children: [
            Text(
              'Let\'s connect!',
              style: GoogleFonts.sora(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => launchUrl(Uri.parse('Tauqeer_Ahmed_Resume.pdf')),
              icon: const Icon(Icons.download),
              label: const Text('DOWNLOAD CV'),
              style: ElevatedButton.styleFrom(
                backgroundColor: textColor,
                foregroundColor: color,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: GoogleFonts.sora(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.email, Constants.email),
                _buildSocialIcon(Icons.link, Constants.linkedin),
                _buildSocialIcon(Icons.code, Constants.githubUri),
              ],
            ),
            const SizedBox(height: 60),
            Text(
              '© 2026 TAUQEER AHMED',
              style: GoogleFonts.sourceCodePro(
                fontSize: 12,
                color: textColor.withValues(alpha: 0.4),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        onPressed: () => launchUrl(Uri.parse(url)),
        icon: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
