import 'package:flutter/material.dart';

enum ScreenSize { mobile, tablet, desktop }

class Responsive {
  static const double mobileBreakpoint = 768;
  static const double tabletBreakpoint = 1100;

  static ScreenSize getSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) return ScreenSize.mobile;
    if (width < tabletBreakpoint) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  static bool isMobile(BuildContext context) =>
      getSize(context) == ScreenSize.mobile;

  static bool isTablet(BuildContext context) =>
      getSize(context) == ScreenSize.tablet;

  static bool isDesktop(BuildContext context) =>
      getSize(context) == ScreenSize.desktop;

  static bool isMobileOrTablet(BuildContext context) =>
      getSize(context) != ScreenSize.desktop;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Responsive font size
  static double fontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    switch (getSize(context)) {
      case ScreenSize.mobile:
        return mobile;
      case ScreenSize.tablet:
        return tablet ?? (mobile + desktop) / 2;
      case ScreenSize.desktop:
        return desktop;
    }
  }

  // Responsive padding
  static EdgeInsets padding(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    switch (getSize(context)) {
      case ScreenSize.mobile:
        return mobile ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
      case ScreenSize.tablet:
        return tablet ??
            const EdgeInsets.symmetric(horizontal: 40, vertical: 24);
      case ScreenSize.desktop:
        return desktop ??
            const EdgeInsets.symmetric(horizontal: 80, vertical: 32);
    }
  }

  // Responsive horizontal padding for sections
  static double sectionPadding(BuildContext context) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) return 20;
    if (width < tabletBreakpoint) return 48;
    if (width < 1400) return 80;
    return (width - 1240) / 2;
  }

  // Grid columns based on screen size
  static int gridColumns(BuildContext context) {
    switch (getSize(context)) {
      case ScreenSize.mobile:
        return 1;
      case ScreenSize.tablet:
        return 2;
      case ScreenSize.desktop:
        return 3;
    }
  }

  // Skills grid columns
  static int skillsColumns(BuildContext context) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) return 2;
    if (width < tabletBreakpoint) return 3;
    if (width < 1400) return 4;
    return 5;
  }

  // Section title font size
  static double sectionTitleSize(BuildContext context) {
    return fontSize(context, mobile: 26, tablet: 32, desktop: 40);
  }

  // Hero name font size
  static double heroNameSize(BuildContext context) {
    return fontSize(context, mobile: 32, tablet: 48, desktop: 64);
  }
}
