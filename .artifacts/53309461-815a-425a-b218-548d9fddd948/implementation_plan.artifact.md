# Implementation Plan - Global Flashlight & Interactive Portfolio (v2)

Transform the site into an interactive portfolio where content is revealed via a global flashlight, avoiding layout overlaps.

## User Review Required

> [!CAUTION]
> **Visibility Control**: Content is 100% obscured by default. Users must use the flashlight (or toggle "Room Light") to see anything. This is a high-impact UX choice.

## Proposed Changes

### [Core UI - Global Flashlight]

#### [MODIFY] [line_painter.dart](file:///D:/flutter/bin/cache/dart-sdk/bin/resources/devtools/assets/portfolio/lib/utils/painters/line_painter.dart)
- Implement a "Hole Punch" mask.
- The painter will fill the entire screen with the `scaffoldBackgroundColor` (or black) and use `BlendMode.dstOut` to clear a cone area.
- Add a "Light Beam" effect: A subtle gradient stroke around the cone edges to simulate light diffusion.
- Take `angle` as a parameter to avoid `Transform.rotate` issues with scroll offsets.

#### [MODIFY] [home.dart](file:///D:/flutter/bin/cache/dart-sdk/bin/resources/devtools/assets/portfolio/lib/screens/home/home.dart)
- Place the `CustomPaint` (flashlight) in a `Positioned.fill` at the end of the root `Stack`.
- **Ignore Pointer**: Wrap the flashlight in `IgnorePointer` so users can still interact with buttons/links *through* the darkness.
- Ensure the flashlight follows the mouse/touch across the entire scrollable area.

---

### [Portfolio Layout & Navigation]

#### [NEW] [floating_nav.dart](file:///D:/flutter/bin/cache/dart-sdk/bin/resources/devtools/assets/portfolio/lib/screens/home/widgets/floating_nav.dart)
- A minimalist, semi-transparent "Floating Island" at the top center.
- Contains links: `Home`, `Experience`, `Projects`, `Connect`.
- This avoids the "overlap" concern of a side rail while providing clear navigation.

#### [MODIFY] [project_card.dart](file:///D:/flutter/bin/cache/dart-sdk/bin/resources/devtools/assets/portfolio/lib/screens/home/widgets/project_card.dart)
- Update to a more modern "Glassmorphism" card style that looks great when revealed by light.
- Add a "Tech Stack" row with icons instead of just text.

---

### [Interactive Elements]

#### [NEW] [room_light_toggle.dart](file:///D:/flutter/bin/cache/dart-sdk/bin/resources/devtools/assets/portfolio/lib/screens/home/widgets/room_light_toggle.dart)
- A dedicated button in the Floating Nav to turn on "Room Lights" (disabling the mask).

## Verification Plan

### Manual Verification
1.  **Flashlight Interaction**: Move the cursor and ensure the "hole" reveals content precisely.
2.  **Scrolling**: Scroll to the bottom; the flashlight should still work and content should be revealed correctly at all scroll offsets.
3.  **Click-through**: Verify that buttons (like GitHub links) are clickable even when "under" the dark mask.
4.  **Floating Nav**: Test navigation links to ensure they scroll to the correct section.
