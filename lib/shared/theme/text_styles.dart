import 'package:flutter/material.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class TextStyles {
  // Header Styles
  static const TextStyle consoleHeader = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 1.2,
  );

  static const TextStyle consoleSubHeader = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.lightAccent,
    letterSpacing: 0.8,
  );

  static const TextStyle consoleBody = TextStyle(
    fontSize: 18,
    height: 1.6,
    color: AppColors.secondaryText,
    letterSpacing: 0.3,
  );

  static const TextStyle consoleFooter = TextStyle(
    fontSize: 16,
    color: AppColors.mutedText,
    letterSpacing: 0.2,
  );

  // Animated Text Styles
  static const TextStyle heroTitle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryText,
    letterSpacing: 2.0,
    height: 1.2,
  );

  static const TextStyle heroSubtitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: AppColors.lightAccent,
    letterSpacing: 1.5,
    height: 1.4,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    letterSpacing: 1.0,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    letterSpacing: 0.5,
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.4,
    letterSpacing: 0.2,
  );

  static const TextStyle chipText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    letterSpacing: 0.3,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
  );

  // Status Text Styles
  static const TextStyle successText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.successColor,
  );

  static const TextStyle warningText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.warningColor,
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.errorColor,
  );
}
