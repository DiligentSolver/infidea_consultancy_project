import 'package:flutter/material.dart';

class MYColors {
  MYColors._();


  ///App Colors

  static const Color primaryColor = Color(0xFF1265A0);
  static const Color primaryDarkColor = Color(0xFF0E4F7D);
  static const Color primaryLightColor = Color(0xFF1A7BBF);
  static const Color primaryDarkerColor = Color(0xFF0A3A5F);
  static const Color primarylighterColor = Color(0xFF2D8FD6);

  static const Color secondaryColor = Color(0xFFE65A1C);
  static const Color secondaryDarkColor = Color(0xFFB84816);
  static const Color secondaryLightColor = Color(0xFFFF6E2A);
  static const Color secondaryDarkerColor = Color(0xFF8A3610);
  static const Color secondarylighterColor = Color(0xFFFF8F4D);

  /// Neutral Colors
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light background
  static const Color surfaceColor = Color(0xFFFFFFFF); // Cards, sheets
  static const Color borderColor = Color(0xFFE0E0E0); // Borders, dividers
  static const Color textPrimaryColor = Color(0xFF333333); // Main text
  static const Color textSecondaryColor = Color(0xFF666666); // Secondary text
  static const Color textDisabledColor = Color(0xFF999999); // Disabled text

  /// Primary Button
  static const Color primaryButtonColor = primaryColor;
  static const Color primaryButtonTextColor = Color(0xFFFFFFFF);
  static const Color primaryButtonHoverColor = primaryLightColor;
  static const Color primaryButtonDisabledColor = Color(0xFFA0C4E0);

/// Secondary Button
  static const Color secondaryButtonColor = secondaryColor;
  static const Color secondaryButtonTextColor = Color(0xFFFFFFFF);
  static const Color secondaryButtonHoverColor = secondaryLightColor;
  static const Color secondaryButtonDisabledColor = Color(0xFFFFC7A3);

/// Outline Button
  static const Color outlineButtonColor = Colors.transparent;
  static const Color outlineButtonBorderColor = primaryColor;
  static const Color outlineButtonTextColor = primaryColor;
  static  Color outlineButtonHoverColor = const Color(0xFF1265A0).withOpacity(0.1);

  /// Card Colors
  static const Color cardBackgroundColor = surfaceColor;
  static const Color cardShadowColor = Color(0x1A000000); // Light shadow
  static const Color cardBorderColor = borderColor;

  ///Input Fields(Text Field, Dropdowns)
  static const Color inputFieldBackgroundColor = surfaceColor;
  static const Color inputFieldBorderColor = borderColor;
  static const Color inputFieldFocusedBorderColor = primaryColor;
  static const Color inputFieldErrorBorderColor = Color(0xFFD32F2F); // Red for errors
  static const Color inputFieldTextColor = textPrimaryColor;
  static const Color inputFieldHintColor = textSecondaryColor;

  ///App Bar Colors
  static const Color appBarBackgroundColor = primaryColor;
  static const Color appBarTextColor = Color(0xFFFFFFFF);
  static const Color appBarIconColor = Color(0xFFFFFFFF);

  /// Colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color shadow = Color(0x40000000);
  static const Color hyperlinkUnvisited = Color(0xFF0000EE);
  static const Color hyperlinkVisited = Color(0xFF551A8B);

  /// Background Colors
  static const Color transparent = Colors.transparent;
  static const Color darkThemeBg = Color(0xFF0F0A1E);
  static const Color lightThemeBg = Color(0xFFFFFFFF);

  /// Background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = MYColors.white.withOpacity(0.1);


  /// light shade
  static const fifthColorShade = Color(0xFFDFFAFF);
  static const redShade = Color(0xFFFF4848);
  static const redLightShade = Color(0xFFFF8484);
  static const greenShade = Color(0xFF85FF88);

  /// Error and Validation Colors
  static const Color errorColor = Color(0xFFD32F2F); // Red for errors
  static const Color successColor = Color(0xFF388E3C); // Green for success
  static const Color warningColor = Color(0xFFFFA000); // Amber for warnings
  static const Color infoColor = Color(0xFF1976D2); // Blue for info

  /// Neutral Shades
  static const darkGrey = Color(0xFF939393);
  static const darkerGrey = Color(0xFF4F4F4F);


  /// Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, primaryLightColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryColor, secondaryLightColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Icon Colors
  static const Color iconColor = textPrimaryColor;
  static const Color iconDisabledColor = textDisabledColor;

  /// Divider Colors
  static const Color dividerColor = borderColor;

  /// Snackbar/Toast Colors
  static const Color snackbarBackgroundColor = Color(0xFF333333);
  static const Color snackbarTextColor = Color(0xFFFFFFFF);

  /// Overlay Colors
  static const Color overlayBackgroundColor = Color(0x80000000);

  /// Shimmer/Skeleton Loader Colors
  static const Color shimmerBaseColor = Color(0xFFE0E0E0);
  static const Color shimmerHighlightColor = Color(0xFFF5F5F5);

  /// Additional Semantic Colors
  static const Color ratingColor = Color(0xFFFFC107);
  static const Color tagColor = Color(0xFFE0F7FA);
  static const Color badgeColor = Color(0xFFD32F2F);

  /// Dark Theme Colors
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkCardColor = Color(0xFF242424);
  static const Color darkBorderColor = Color(0xFF444444);
  static const Color darkDividerColor = Color(0xFF444444);
  static const Color darkTextPrimaryColor = Color(0xFFFFFFFF);
  static const Color darkTextSecondaryColor = Color(0xFFCCCCCC);
  static const Color darkTextDisabledColor = Color(0xFF888888);

  /// Button Colors (Dark Theme)
  static const Color darkPrimaryButtonColor = primaryColor;
  static const Color darkPrimaryButtonTextColor = Color(0xFFFFFFFF);
  static const Color darkPrimaryButtonHoverColor = primaryLightColor;
  static const Color darkPrimaryButtonDisabledColor = Color(0xFF0A3A5F);

  static const Color darkSecondaryButtonColor = secondaryColor;
  static const Color darkSecondaryButtonTextColor = secondaryButtonTextColor;
  static const Color darkSecondaryButtonHoverColor = secondaryLightColor;
  static const Color darkSecondaryButtonDisabledColor = secondaryDarkerColor;

  static const Color darkOutlineButtonColor = Colors.transparent;
  static const Color darkOutlineButtonBorderColor = primaryColor;
  static const Color darkOutlineButtonTextColor = primaryColor;
  static final Color darkOutlineButtonHoverColor = const Color(0xFF1265A0).withOpacity(0.1);

  /// Input Fields (Dark Theme)
  static const Color darkInputFieldBackgroundColor = darkSurfaceColor;
  static const Color darkInputFieldBorderColor = darkBorderColor;
  static const Color darkInputFieldFocusedBorderColor = primaryColor;
  static const Color darkInputFieldErrorBorderColor = redLightShade;
  static const Color darkInputFieldTextColor = darkTextPrimaryColor;
  static const Color darkInputFieldHintColor = darkTextSecondaryColor;

  /// AppBar Colors (Dark Theme)
  static const Color darkAppBarBackgroundColor = Color(0xFF1E1E1E);
  static const Color darkAppBarTextColor = Color(0xFFFFFFFF);
  static const Color darkAppBarIconColor = Color(0xFFFFFFFF);

  /// Card Colors (Dark Theme)
  static const Color darkCardBackgroundColor = darkSurfaceColor;
  static const Color darkCardShadowColor = Color(0x1AFFFFFF);
  static const Color darkCardBorderColor = darkBorderColor;

  /// Snackbar/Toast Colors (Dark Theme)
  static const Color darkSnackbarBackgroundColor = Color(0xFF333333);
  static const Color darkSnackbarTextColor = Color(0xFFFFFFFF);

  /// Icon Colors (Dark Theme)
  static const Color darkIconColor = darkTextPrimaryColor;
  static const Color darkIconDisabledColor = darkTextDisabledColor;

  /// Hover and Active States (Dark Theme)
  static const Color darkHoverColor = Color(0x1AFFFFFF);
  static const Color darkActiveColor = Color(0x33FFFFFF);

  /// Gradients (Dark Theme)
  static const LinearGradient darkPrimaryGradient = LinearGradient(
    colors: [primaryDarkColor, primaryDarkerColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkSecondaryGradient = LinearGradient(
    colors: [secondaryDarkColor, secondaryDarkerColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Semantic Colors (Dark Theme)
  static const Color darkErrorColor = Color(0xFFD32F2F);
  static const Color darkSuccessColor = Color(0xFF388E3C);
  static const Color darkWarningColor = Color(0xFFFFA000);
  static const Color darkInfoColor = Color(0xFF1976D2);


}
