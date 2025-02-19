import 'package:flutter/material.dart';

Widget verticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget horizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

class MySizes {

///Progress Indicator
  static const double progressIndicatorStrokeWidth = 4.0; // Width of the circular progress indicator stroke
  static const double progressIndicatorHeight = 4.0; // Height of the linear progress indicator

  ///Percentage Sizes

  static const ten = 0.1;
  static const twenty = 0.2;
  static const thirty = 0.3;
  static const fourty = 0.4;
  static const fifty = 0.5;
  static const sixty = 0.6;
  static const seventy = 0.7;
  static const eighty = 0.8;
  static const ninty = 0.9;

  /// Padding and margin sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double cSMd = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  /// Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
  static const double iconXxl = 64.0;

  ///Radio Button Sizes
  static const double splashRadius = 30.0;

  /// Font sizes
  static const double caption = 10.0;
  static const double labelSmall = 11.0;
  static const double labelMedium = 12.0;
  static const double labelLarge = 14.0;
  static const double bodySmall = 12.0;
  static const double bodyMedium = 14.0;
  static const double bodyLarge = 16.0;
  static const double titleSmall = 16.0;
  static const double titleMedium = 18.0;
  static const double titleLarge = 22.0;
  static const double headlineSmall = 24.0;
  static const double headlineMedium = 28.0;
  static const double headlineLarge = 32.0;
  static const double displaySmall = 36.0;
  static const double displayMedium = 45.0;
  static const double displayLarge = 57.0;

  /// Button sizes
  static const double buttonHeight = 48.0;
  static const double buttonHeightSm = 36.0;
  static const double buttonHeightMd = 48.0;
  static const double buttonHeightLg = 56.0;
  static const double buttonRadius = 12.0;
  static const double buttonRadiusSm = 8.0;
  static const double buttonRadiusLg = 16.0;
  static const double buttonWidth = 120.0;

  /// AppBar height
  static const double appbarHeight = 56.0;
  static const double appbarCollapsedHeight = 56.0;
  static const double appbarExpandedHeight = 120.0;

  /// Image sizes
  static const double imageThumbSize = 80.0;
  static const double imageAvatarSize = 40.0;
  static const double imageBannerHeight = 200.0;
  static const double imageBannerHeightMd = 250.0;
  static const double imageBannerHeightLg = 300.0;
  static const double imageThumbSizeSm = 60.0;
  static const double imageThumbSizeLg = 100.0;

  /// Default spacing between sections
  static const double defaultSpace = 20.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwItemsSm = 8.0;
  static const double spaceBtwItemsLg = 24.0;
  static const double spaceBtwSections = 32.0;
  static const double spaceBtwSectionsSm = 16.0;
  static const double spaceBtwSectionsLg = 48.0;

  /// Border radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;
  static const double borderRadiusXl = 16.0;
  static const double borderRadiusXxl = 24.0;

  /// Divider height
  static const double dividerHeight = 1.0;
  static const double dividerHeightSm = 0.5;
  static const double dividerHeightLg = 2.0;

  /// Input field
  static const double inputFieldRadius = 12.0;
  static const double inputFieldRadiusSm = 8.0;
  static const double inputFieldRadiusMd = 14.0;
  static const double inputFieldRadiusLg = 16.0;
  static const double inputFieldHeight = 48.0;
  static const double spaceBtwInputFields = 16.0;

  /// Card Sizes
  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusXs = 6.0;
  static const double cardRadiusXl = 20.0;
  static const double cardElevation = 2.0;
  static const double cardElevationSm = 1.0;
  static const double cardElevationLg = 4.0;

  /// Loading indicator size
  static const double loadingIndicatorSize = 36.0;
  static const double loadingIndicatorSizeSm = 24.0;
  static const double loadingIndicatorSizeLg = 48.0;

  /// List view spacing
  static const double listViewSpacing = 16.0;
  static const double listViewSpacingSm = 8.0;
  static const double listViewSpacingLg = 24.0;

  /// Grid spacing
  static const double gridSpacing = 8.0;
  static const double gridSpacingLg = 16.0;

  /// Modal and Dialog Sizes
  static const double modalRadius = 16.0;
  static const double modalWidth = 400.0;
  static const double modalHeight = 300.0;

  /// Tab Bar Sizes
  static const double tabBarHeight = 48.0;
  static const double tabBarIndicatorHeight = 2.0;

  /// Elevation and Shadow Sizes
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double elevationXl = 16.0;

  /// Floating Action Button (FAB) sizes
  static const double fabSizeSm = 40.0;
  static const double fabSizeMd = 56.0;
  static const double fabSizeLg = 64.0;

  /// Bottom Navigation Bar sizes
  static const double bottomNavBarHeight = 56.0;
  static const double bottomNavBarIconSize = 24.0;
  static const double bottomNavBarLabelSize = 12.0;

  /// Drawer sizes
  static const double drawerWidth = 304.0;
  static const double drawerHeaderHeight = 120.0;
  static const double drawerItemHeight = 48.0;

  /// Toolbar and Action Bar sizes
  static const double toolbarHeight = 56.0;
  static const double actionBarHeight = 48.0;

  /// Progress Indicator sizes
  static const double progressIndicatorSizeSm = 24.0;
  static const double progressIndicatorSizeMd = 36.0;
  static const double progressIndicatorSizeLg = 48.0;

  /// Chip sizes
  static const double chipHeight = 32.0;
  static const double chipRadius = 16.0;
  static const double chipPadding = 8.0;

  /// Badge sizes
  static const double badgeSizeSm = 16.0;
  static const double badgeSizeMd = 24.0;
  static const double badgeSizeLg = 32.0;

  /// Avatar sizes
  static const double avatarSizeSm = 32.0;
  static const double avatarSizeMd = 48.0;
  static const double avatarSizeLg = 64.0;

  /// Tab Bar Indicator sizes
  static const double tabBarIndicatorHeightSm = 2.0;
  static const double tabBarIndicatorHeightMd = 4.0;
  static const double tabBarIndicatorHeightLg = 6.0;

  /// Snackbar sizes
  static const double snackbarHeight = 48.0;
  static const double snackbarPadding = 16.0;

  /// Tooltip sizes
  static const double tooltipHeight = 32.0;
  static const double tooltipPadding = 8.0;

  /// Dropdown Menu sizes
  static const double dropdownMenuHeight = 200.0;
  static const double dropdownMenuItemHeight = 48.0;

  /// Stepper sizes
  static const double stepperHeight = 72.0;
  static const double stepperCircleRadius = 12.0;

  /// Segmented Control sizes
  static const double segmentedControlHeight = 40.0;
  static const double segmentedControlRadius = 8.0;
}
