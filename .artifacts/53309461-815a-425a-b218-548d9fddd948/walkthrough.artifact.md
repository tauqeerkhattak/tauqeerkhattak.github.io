# Global Flashlight Portfolio Walkthrough

I have transformed the portfolio into an immersive "flashlight" experience where content is revealed only by the light beam, covering the entire page.

## Key Accomplishments

### 🔦 Global Flashlight System
- **[LinePainter](file:///D:/flutter/bin/cache/dart-sdk/bin/resources/devtools/assets/portfolio/lib/utils/painters/line_painter.dart)**: Completely redesigned to use a "Hole Punch" technique (`BlendMode.dstOut`). It draws a full-screen dark mask and clears a cone-shaped area that follows the cursor.
- **Scroll-Aware Visibility**: The flashlight is now a fixed overlay in the root `Stack` of the **[Home](file:///D:/flutter/bin/cache/dart-sdk/bin/resources/devtools/assets/portfolio/lib/screens/home/home.dart)** page, ensuring it covers all content as the user scrolls.

### 🏝️ Floating Navigation
- **[FloatingNav](file:///D:/flutter/bin/cache/dart-sdk/bin/resources/devtools/assets/portfolio/lib/screens/home/widgets/floating_nav.dart)**: Replaced the side rail with a sleek, top-center "Floating Island" to avoid layout overlaps.
- **Section Anchors**: Implemented smooth scrolling to `Home`, `Experience`, `Projects`, and `Connect` sections using `GlobalKey` and `Scrollable.ensureVisible`.

### ✨ Interactive & Accessible UX
- **Room Light Toggle**: Added a lightbulb icon in the navigation bar that allows users to turn on the "room lights," disabling the mask for better readability when needed.
- **Click-Through Interaction**: Wrapped the flashlight overlay in `IgnorePointer`, allowing users to interact with buttons, links, and cards directly through the beam of light.
- **[ProjectCard](file:///D:/flutter/bin/cache/dart-sdk/bin/resources/devtools/assets/portfolio/lib/screens/home/widgets/project_card.dart)**: Upgraded to a modern card style with glassmorphism effects that pop when hit by the light.

## Verification
- **Flashlight**: Verified the cone follows the cursor and touch input across the entire scrollable height.
- **Interactivity**: Tested that GitHub links and section jumps work perfectly through the dark overlay.
- **Theme Support**: Verified that both Light and Dark modes are supported, with the mask color adapting (Black for Dark mode, White for Light mode).
