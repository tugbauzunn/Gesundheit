import 'package:flutter/material.dart';
import 'app_colors.dart';
import '../utils/responsive_utils.dart';

class AppStyles {
  // Text Styles
  static TextStyle headingLarge(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtils.getTitleFontSize(context) + 4,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle headingMedium(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtils.getTitleFontSize(context),
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle headingSmall(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtils.getButtonFontSize(context),
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtils.getButtonFontSize(context),
      color: AppColors.textPrimary,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtils.getBodyFontSize(context),
      color: AppColors.textSecondary,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtils.getBodyFontSize(context) - 1,
      color: AppColors.textLight,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtils.getButtonFontSize(context),
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }

  // Card Decorations
  static BoxDecoration cardDecoration(
    BuildContext context, {
    Color? backgroundColor,
    bool hasShadow = true,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? AppColors.cardBackground,
      borderRadius: BorderRadius.circular(
        ResponsiveUtils.getBorderRadius(context),
      ),
      boxShadow: hasShadow
          ? [
              BoxShadow(
                color: AppColors.withAlpha(AppColors.primary, 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
          : null,
    );
  }

  static BoxDecoration roundedCardDecoration(
    BuildContext context, {
    Color? backgroundColor,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? AppColors.cardBackground,
      borderRadius: BorderRadius.circular(
        ResponsiveUtils.getSmallBorderRadius(context),
      ),
      border: Border.all(color: AppColors.border),
    );
  }

  // Button Styles
  static ButtonStyle primaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: AppColors.withAlpha(AppColors.primary, 0.6),
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.getVerticalPadding(context),
        horizontal: ResponsiveUtils.getHorizontalPadding(context) * 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context),
        ),
      ),
      elevation: 0,
      minimumSize: Size(
        double.infinity,
        ResponsiveUtils.getButtonHeight(context),
      ),
    );
  }

  // Input Decorations
  static InputDecoration textFieldDecoration(
    BuildContext context, {
    String? hintText,
    String? labelText,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: bodyMedium(context),
      hintText: hintText,
      hintStyle: bodySmall(context),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getSmallBorderRadius(context),
        ),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getSmallBorderRadius(context),
        ),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getSmallBorderRadius(context),
        ),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      contentPadding: EdgeInsets.all(
        ResponsiveUtils.getHorizontalPadding(context),
      ),
    );
  }

  // Shadow Styles
  static List<BoxShadow> cardShadow(BuildContext context, {double? alpha}) {
    return [
      BoxShadow(
        color: AppColors.withAlpha(AppColors.primary, alpha ?? 0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }

  static List<BoxShadow> buttonShadow(BuildContext context) {
    return [
      BoxShadow(
        color: AppColors.withAlpha(AppColors.primary, 0.3),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ];
  }

  // Padding Helpers
  static EdgeInsets cardPadding(BuildContext context) {
    return EdgeInsets.all(ResponsiveUtils.getCardPadding(context));
  }

  static EdgeInsets horizontalPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: ResponsiveUtils.getHorizontalPadding(context),
    );
  }

  static EdgeInsets verticalPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      vertical: ResponsiveUtils.getVerticalPadding(context),
    );
  }
}
