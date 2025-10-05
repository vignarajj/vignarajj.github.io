import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/shared/theme/app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: GoogleFonts.sourceCodePro().fontFamily, // Set global font family

    // Color Scheme - Pure Black & White
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColors.pureWhite,
      onPrimary: AppColors.pureBlack,
      secondary: AppColors.lightAccent,
      onSecondary: AppColors.pureBlack,
      tertiary: AppColors.mediumAccent,
      onTertiary: AppColors.pureWhite,
      surface: AppColors.primaryBackground,
      onSurface: AppColors.primaryText,
      surfaceContainerHighest: AppColors.cardBackground,
      surfaceContainer: AppColors.secondaryBackground,
      surfaceContainerLow: AppColors.surfaceColor,
      outline: AppColors.borderColor,
      outlineVariant: AppColors.lightBorder,
      inversePrimary: AppColors.pureBlack,
      inverseSurface: AppColors.pureWhite,
      onInverseSurface: AppColors.pureBlack,
      error: AppColors.errorColor,
      onError: AppColors.primaryText,
      scrim: AppColors.pureBlack,
      shadow: AppColors.pureBlack,
    ),

    // Primary Colors
    primaryColor: AppColors.pureWhite,
    primaryColorDark: AppColors.appAccentColor,
    primaryColorLight: AppColors.lightAccent,

    // Background Colors
    scaffoldBackgroundColor: AppColors.primaryBackground,
    canvasColor: AppColors.secondaryBackground,
    cardColor: AppColors.cardBackground,
    dividerColor: AppColors.borderColor,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryBackground,
      foregroundColor: AppColors.primaryText,
      elevation: 0,
      shadowColor: AppColors.pureBlack,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.sourceCodePro(
        color: AppColors.primaryText,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      iconTheme: const IconThemeData(color: AppColors.primaryText, size: 24),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryBackground,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.primaryBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),

    // Text Theme using Google Fonts
    textTheme: GoogleFonts.sourceCodeProTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
        ),
        displayMedium: TextStyle(
          color: AppColors.primaryText,
          fontSize: 45,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: AppColors.primaryText,
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 32,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: TextStyle(
          color: AppColors.primaryText,
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: AppColors.primaryText,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          color: AppColors.primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          color: AppColors.mutedText,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
        labelLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          color: AppColors.mutedText,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pureWhite,
        foregroundColor: AppColors.pureBlack,
        elevation: 8,
        shadowColor: AppColors.pureBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryText,
        side: const BorderSide(color: AppColors.borderColor, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: AppColors.primaryText, size: 24),

    primaryIconTheme: const IconThemeData(color: AppColors.pureBlack, size: 24),

    // Card Theme
    cardTheme: const CardThemeData(
      color: AppColors.cardBackground,
      elevation: 4,
      shadowColor: AppColors.pureBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        side: BorderSide(color: AppColors.borderColor, width: 0.5),
      ),
      margin: EdgeInsets.all(8),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackground,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.pureWhite, width: 2),
      ),
      labelStyle: GoogleFonts.sourceCodePro(color: AppColors.secondaryText),
      hintStyle: GoogleFonts.sourceCodePro(color: AppColors.mutedText),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey.shade800,
      foregroundColor: Colors.white,
      iconSize: 36,
      splashColor: Colors.grey.shade700,
      elevation: 12,
      shape: CircleBorder(),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.borderColor,
      thickness: 1,
      space: 1,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.cardBackground,
      deleteIconColor: AppColors.secondaryText,
      disabledColor: AppColors.surfaceColor,
      selectedColor: AppColors.pureWhite,
      secondarySelectedColor: AppColors.lightAccent,
      labelStyle: GoogleFonts.sourceCodePro(color: AppColors.primaryText),
      secondaryLabelStyle: GoogleFonts.sourceCodePro(color: AppColors.pureBlack),
      brightness: Brightness.dark,
      elevation: 2,
      pressElevation: 4,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryBackground,
      selectedItemColor: AppColors.pureWhite,
      unselectedItemColor: AppColors.mutedText,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Snack Bar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.cardBackground,
      contentTextStyle: GoogleFonts.sourceCodePro(color: AppColors.primaryText),
      actionTextColor: AppColors.pureWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 6,
    ),
  );
}
