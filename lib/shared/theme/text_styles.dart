import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class TextStyles {
  // Header Styles
  static TextStyle get consoleHeader => GoogleFonts.sourceCodePro(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 1.2,
  );

  static TextStyle get consoleSubHeader => GoogleFonts.sourceCodePro(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.lightAccent,
    letterSpacing: 0.8,
  );

  static TextStyle get consoleBody => GoogleFonts.sourceCodePro(
    fontSize: 18,
    height: 1.6,
    color: AppColors.secondaryText,
    letterSpacing: 0.3,
  );

  static TextStyle get consoleFooter => GoogleFonts.sourceCodePro(
    fontSize: 16,
    color: AppColors.mutedText,
    letterSpacing: 0.2,
  );

  // Profile Styles
  static TextStyle get profileName => GoogleFonts.sourceCodePro(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 1.2,
  );

  static TextStyle get profileNameMobile => GoogleFonts.sourceCodePro(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 1.0,
  );

  static TextStyle get profileSubtitle => GoogleFonts.sourceCodePro(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.lightAccent,
    letterSpacing: 0.5,
  );

  static TextStyle get profileSubtitleMobile => GoogleFonts.sourceCodePro(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.lightAccent,
    letterSpacing: 0.5,
  );

  // Section Styles
  static TextStyle get sectionTitle => GoogleFonts.sourceCodePro(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.lightAccent,
    letterSpacing: 0.8,
  );

  static TextStyle get sectionTitleMobile => GoogleFonts.sourceCodePro(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.lightAccent,
    letterSpacing: 0.8,
  );

  static TextStyle get sectionDescription => GoogleFonts.sourceCodePro(
    fontSize: 15,
    color: AppColors.primaryText,
    height: 1.5,
    letterSpacing: 0.3,
  );

  static TextStyle get sectionDescriptionMobile => GoogleFonts.sourceCodePro(
    fontSize: 13,
    color: AppColors.primaryText,
    height: 1.5,
    letterSpacing: 0.3,
  );

  // Card Styles
  static TextStyle get cardTitle => GoogleFonts.sourceCodePro(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    letterSpacing: 0.5,
  );

  static TextStyle get cardTitleMobile => GoogleFonts.sourceCodePro(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    letterSpacing: 0.5,
  );

  static TextStyle get cardDescription => GoogleFonts.sourceCodePro(
    fontSize: 13,
    color: AppColors.secondaryText,
    height: 1.4,
    letterSpacing: 0.2,
  );

  static TextStyle get cardDescriptionMobile => GoogleFonts.sourceCodePro(
    fontSize: 11,
    color: AppColors.secondaryText,
    height: 1.4,
    letterSpacing: 0.2,
  );

  // Skill Styles
  static TextStyle get skillName => GoogleFonts.sourceCodePro(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.3,
  );

  static TextStyle get skillNameMobile => GoogleFonts.sourceCodePro(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.3,
  );

  static TextStyle get skillPercentage => GoogleFonts.sourceCodePro(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedText,
    letterSpacing: 0.2,
  );

  static TextStyle get skillPercentageMobile => GoogleFonts.sourceCodePro(
    fontSize: 8,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedText,
    letterSpacing: 0.2,
  );

  // Button Styles
  static TextStyle get buttonText => GoogleFonts.sourceCodePro(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
  );

  static TextStyle get buttonTextSmall => GoogleFonts.sourceCodePro(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,
  );

  // Form Styles
  static TextStyle get formLabel => GoogleFonts.sourceCodePro(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.lightAccent,
  );

  static TextStyle get formInput => GoogleFonts.sourceCodePro(
    fontSize: 14,
    color: AppColors.pureWhite,
  );

  static TextStyle get formHint => GoogleFonts.sourceCodePro(
    fontSize: 14,
    color: AppColors.mutedText,
  );

  static TextStyle get formError => GoogleFonts.sourceCodePro(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.errorColor,
  );

  // Chat Styles
  static TextStyle get chatTitle => GoogleFonts.sourceCodePro(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static TextStyle get chatQuestion => GoogleFonts.sourceCodePro(
    fontSize: 16,
    color: AppColors.primaryText,
  );

  static TextStyle get chatMessage => GoogleFonts.sourceCodePro(
    fontSize: 14,
    color: AppColors.primaryText,
  );

  static TextStyle get chatInput => GoogleFonts.sourceCodePro(
    fontSize: 14,
    color: AppColors.primaryText,
  );

  static TextStyle get chatError => GoogleFonts.sourceCodePro(
    fontSize: 12,
    color: AppColors.errorColor,
  );

  // Chip Styles
  static TextStyle get chipText => GoogleFonts.sourceCodePro(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.3,
  );

  static TextStyle get chipTextMobile => GoogleFonts.sourceCodePro(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.3,
  );

  // Status Text Styles
  static TextStyle get successText => GoogleFonts.sourceCodePro(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.successColor,
  );

  static TextStyle get warningText => GoogleFonts.sourceCodePro(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.warningColor,
  );

  static TextStyle get errorText => GoogleFonts.sourceCodePro(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.errorColor,
  );

  // Hero text styles (for animated text widgets)
  static TextStyle get heroTitle => GoogleFonts.sourceCodePro(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryText,
    letterSpacing: 2.0,
    height: 1.2,
  );

  static TextStyle get heroSubtitle => GoogleFonts.sourceCodePro(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: AppColors.lightAccent,
    letterSpacing: 1.5,
    height: 1.4,
  );

  // Responsive text style helper
  static TextStyle getResponsiveTextStyle(
    double width, {
    required TextStyle desktop,
    required TextStyle mobile,
  }) {
    return width > 600 ? desktop : mobile;
  }
}