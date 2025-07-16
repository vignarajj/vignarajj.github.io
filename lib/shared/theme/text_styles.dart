import 'package:flutter/material.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class TextStyles {
  // Font family
  static const String fontFamily = 'SourceCodePro';

  // Header Styles
  static const TextStyle consoleHeader = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 1.2,
  );

  static const TextStyle consoleSubHeader = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.lightAccent,
    letterSpacing: 0.8,
  );

  static const TextStyle consoleBody = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 1.6,
    color: AppColors.secondaryText,
    letterSpacing: 0.3,
  );

  static const TextStyle consoleFooter = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    color: AppColors.mutedText,
    letterSpacing: 0.2,
  );

  // Profile Styles
  static const TextStyle profileName = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 1.2,
  );

  static const TextStyle profileNameMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 1.0,
  );

  static const TextStyle profileSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.lightAccent,
    letterSpacing: 0.5,
  );

  static const TextStyle profileSubtitleMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.lightAccent,
    letterSpacing: 0.5,
  );

  // Section Styles
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.lightAccent,
    letterSpacing: 0.8,
  );

  static const TextStyle sectionTitleMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.lightAccent,
    letterSpacing: 0.8,
  );

  static const TextStyle sectionDescription = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    color: AppColors.primaryText,
    height: 1.5,
    letterSpacing: 0.3,
  );

  static const TextStyle sectionDescriptionMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    color: AppColors.primaryText,
    height: 1.5,
    letterSpacing: 0.3,
  );

  // Card Styles
  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    letterSpacing: 0.5,
  );

  static const TextStyle cardTitleMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    letterSpacing: 0.5,
  );

  static const TextStyle cardDescription = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    color: AppColors.secondaryText,
    height: 1.4,
    letterSpacing: 0.2,
  );

  static const TextStyle cardDescriptionMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    color: AppColors.secondaryText,
    height: 1.4,
    letterSpacing: 0.2,
  );

  // Skill Styles
  static const TextStyle skillName = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.3,
  );

  static const TextStyle skillNameMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.3,
  );

  static const TextStyle skillPercentage = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedText,
    letterSpacing: 0.2,
  );

  static const TextStyle skillPercentageMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedText,
    letterSpacing: 0.2,
  );

  // Button Styles
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
  );

  static const TextStyle buttonTextSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,
  );

  // Form Styles
  static const TextStyle formLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.lightAccent,
  );

  static const TextStyle formInput = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: AppColors.pureWhite,
  );

  static const TextStyle formHint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: AppColors.mutedText,
  );

  static const TextStyle formError = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    color: AppColors.errorColor,
  );

  // Chat Styles
  static const TextStyle chatTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static const TextStyle chatQuestion = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    color: AppColors.primaryText,
  );

  static const TextStyle chatMessage = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: AppColors.primaryText,
  );

  static const TextStyle chatInput = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: AppColors.primaryText,
  );

  static const TextStyle chatError = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    color: AppColors.errorColor,
  );

  // Chip Styles
  static const TextStyle chipText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.3,
  );

  static const TextStyle chipTextMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.3,
  );

  // Status Text Styles
  static const TextStyle successText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.successColor,
  );

  static const TextStyle warningText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.warningColor,
  );

  static const TextStyle errorText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.errorColor,
  );

  // Hero text styles (for animated text widgets)
  static const TextStyle heroTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryText,
    letterSpacing: 2.0,
    height: 1.2,
  );

  static const TextStyle heroSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: AppColors.lightAccent,
    letterSpacing: 1.5,
    height: 1.4,
  );

  // Responsive text style helper
  static TextStyle getResponsiveTextStyle(double width, {
    required TextStyle desktop,
    required TextStyle mobile,
  }) {
    return width > 600 ? desktop : mobile;
  }
}
