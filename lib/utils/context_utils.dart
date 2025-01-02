import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension ContextUtils on BuildContext {
  T when<T>({
    required T desktop,
    required T tablet,
    required T mobile,
  }) {
    final breakpoint = ResponsiveBreakpoints.of(this);
    switch (breakpoint.breakpoint.name) {
      case MOBILE:
        return mobile;
      case TABLET:
        return tablet;
      case DESKTOP:
        return desktop;
      default:
        return tablet;
    }
  }
}
