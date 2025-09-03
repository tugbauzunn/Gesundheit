import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 480;
  }

  static bool isSmallMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 360;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }

  // Font boyutları
  static double getButtonFontSize(BuildContext context) {
    if (isSmallMobile(context)) return 14.0;
    if (isMobile(context)) return 15.0;
    return 16.0;
  }

  static double getBodyFontSize(BuildContext context) {
    if (isSmallMobile(context)) return 12.0;
    if (isMobile(context)) return 13.0;
    return 14.0;
  }

  static double getTitleFontSize(BuildContext context) {
    if (isSmallMobile(context)) return 16.0;
    if (isMobile(context)) return 18.0;
    return 20.0;
  }

  // Padding değerleri
  static double getCardPadding(BuildContext context) {
    if (isSmallMobile(context)) return 16.0;
    if (isMobile(context)) return 20.0;
    return 24.0;
  }

  static double getHorizontalPadding(BuildContext context) {
    if (isSmallMobile(context)) return 12.0;
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 24.0;
    return 16.0;
  }

  static double getVerticalPadding(BuildContext context) {
    if (isSmallMobile(context)) return 12.0;
    if (isMobile(context)) return 16.0;
    return 20.0;
  }

  // Border radius
  static double getBorderRadius(BuildContext context) {
    return isSmallMobile(context) ? 12.0 : 16.0;
  }

  static double getSmallBorderRadius(BuildContext context) {
    return isSmallMobile(context) ? 10.0 : 12.0;
  }

  // Button boyutları
  static double getButtonHeight(BuildContext context) {
    if (isSmallMobile(context)) return 48.0;
    if (isMobile(context)) return 52.0;
    return 56.0;
  }

  // Icon boyutları
  static double getIconSize(BuildContext context) {
    if (isSmallMobile(context)) return 24.0;
    if (isMobile(context)) return 26.0;
    return 28.0;
  }

  // Loading indicator boyutu
  static double getLoadingSize(BuildContext context) {
    return isSmallMobile(context) ? 18.0 : 20.0;
  }

  // Spacing değerleri
  static double getVerticalSpacing(BuildContext context) {
    if (isSmallMobile(context)) return 16.0;
    if (isMobile(context)) return 20.0;
    return 24.0;
  }
}
