class AppDimensions {
  // Spacing values
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;

  // Padding values
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 12.0;
  static const double paddingLarge = 16.0;
  static const double paddingXLarge = 20.0;
  static const double paddingXXLarge = 24.0;
  static const double paddingXXXLarge = 32.0;

  // Border radius values
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  static const double radiusXXLarge = 24.0;

  // Icon sizes
  static const double iconXSmall = 16.0;
  static const double iconSmall = 18.0;
  static const double iconMedium = 20.0;
  static const double iconLarge = 24.0;
  static const double iconXLarge = 28.0;
  static const double iconXXLarge = 32.0;

  // Avatar sizes
  static const double avatarSmall = 40.0;
  static const double avatarMedium = 60.0;
  static const double avatarLarge = 80.0;
  static const double avatarXLarge = 100.0;

  // Container dimensions
  static const double containerHeight = 48.0;
  static const double containerHeightLarge = 56.0;
  static const double containerHeightXLarge = 64.0;

  // Button dimensions
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightLarge = 56.0;
  static const double buttonMinWidth = 88.0;

  // Card dimensions
  static const double cardElevation = 4.0;
  static const double cardElevationHover = 8.0;
  static const double cardElevationPressed = 2.0;

  // Grid layout
  static const int gridCrossAxisCountMobile = 3;
  static const int gridCrossAxisCountDesktop = 6;
  static const int gridCrossAxisCountPlugins = 2;
  static const double gridCrossAxisSpacingMobile = 8.0;
  static const double gridCrossAxisSpacingDesktop = 16.0;
  static const double gridChildAspectRatio = 1.2;

  // Responsive breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 800.0;
  static const double desktopBreakpoint = 1200.0;
  static const double homeDesktopBreakpoint = 700.0;

  // Layout constraints
  static const double maxContentWidth = 800.0;
  static const double maxFormWidth = 600.0;
  
  // Loading screen
  static const double loadingAnimationSize = 150.0;
  static const int loadingDelayMilliseconds = 2500;
  
  // Home specific dimensions
  static const double homeHorizontalPaddingDesktop = 40.0;
  static const double homeHorizontalPaddingMobile = 12.0;
  static const double homeVerticalPaddingDesktop = 48.0;
  static const double homeVerticalPaddingMobile = 16.0;
  
  // Bottom bar
  static const double bottomBarHeightDesktop = 80.0;
  static const double bottomBarHeightMobile = 70.0;
  static const double bottomBarPaddingDesktop = 24.0;
  static const double bottomBarPaddingMobile = 16.0;
  static const double bottomBarButtonHeight = 46.0;
  
  // Profile section
  static const double profileAvatarRadiusDesktop = 80.0;
  static const double profileAvatarRadiusMobile = 60.0;
  static const double profileAvatarBorderWidth = 2.0;
  
  // Grid layouts
  static const int skillsGridCrossAxisCountDesktop = 6;
  static const int skillsGridCrossAxisCountMobile = 3;
  static const int projectsGridCrossAxisCountDesktop = 3;
  static const int pluginsGridCrossAxisCountDesktop = 2;
  static const int pluginsGridCrossAxisCountMobile = 2;
  static const int servicesGridCrossAxisCountDesktop = 2;
  
  // Grid spacing
  static const double skillsGridSpacingDesktop = 12.0;
  static const double skillsGridSpacingMobile = 8.0;
  static const double projectsGridSpacing = 16.0;
  static const double pluginsGridSpacingDesktop = 16.0;
  static const double pluginsGridSpacingMobile = 8.0;
  static const double servicesGridSpacing = 16.0;
  
  // Grid aspect ratios
  static const double skillsGridAspectRatioDesktop = 1.2;
  static const double skillsGridAspectRatioMobile = 1.0;
  static const double projectsGridAspectRatio = 1.0;
  static const double pluginsGridAspectRatioDesktop = 1.5;
  static const double pluginsGridAspectRatioMobile = 1.0;
  static const double servicesGridAspectRatio = 1.2;
  
  // Card heights
  static const double projectCardHeightMobile = 180.0;
  static const double serviceCardHeightMobile = 180.0;
  
  // Skill card icons
  static const double skillIconSizeDesktop = 28.0;
  static const double skillIconSizeMobile = 22.0;
  
  // Animation durations
  static const int scrollAnimationDurationMs = 800;
  static const int navigationDelayMs = 200;
  static const int loadingInitialDelayMs = 100;
  
  // Shadow properties
  static const double shadowOffsetY = 4.0;
  static const double shadowOffsetNegativeY = -2.0;
  static const double shadowSpreadRadius = 2.0;
  
  // Chip/Tag dimensions
  static const double chipHeightSmall = 20.0;
  static const double chipHeightMedium = 28.0;
  static const double chipPaddingHorizontal = 8.0;
  static const double chipPaddingVertical = 6.0;
  static const double chipMarginRight = 8.0;
  static const double chipMarginRightSmall = 6.0;
  static const double chipMarginRightTiny = 4.0;

  // Shadow values
  static const double shadowBlurSmall = 4.0;
  static const double shadowBlurMedium = 8.0;
  static const double shadowBlurLarge = 12.0;
  static const double shadowBlurXLarge = 20.0;

  // Responsive helper methods
  static bool isMobile(double width) => width < mobileBreakpoint;
  static bool isTablet(double width) => width >= mobileBreakpoint && width < desktopBreakpoint;
  static bool isDesktop(double width) => width >= desktopBreakpoint;
  
  // Responsive spacing
  static double getSpacing(double width, {double mobile = 16.0, double desktop = 24.0}) {
    return isMobile(width) ? mobile : desktop;
  }
  
  // Responsive padding
  static double getPadding(double width, {double mobile = 12.0, double desktop = 16.0}) {
    return isMobile(width) ? mobile : desktop;
  }
}