import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import '../constants/colors.dart';

class Bars {
  static void showErrorSnackBar({
    required BuildContext context,
    required String title,
    String message = '',
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: MYAppTextStyles.labelLarge().copyWith(
              color: MYColors.snackbarTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (message.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              message,
              style: MYAppTextStyles.labelLarge().copyWith(
                color: MYColors.snackbarTextColor,
              ),
            ),
          ],
        ],
      ),
      backgroundColor: MYColors.errorColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusLg),
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: MYColors.snackbarTextColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      dismissDirection: DismissDirection.horizontal,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showWarningSnackBar({
    required BuildContext context,
    required String title,
    String message = '',
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: MYAppTextStyles.labelLarge().copyWith(
              color: MYColors.textPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (message.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              message,
              style: MYAppTextStyles.labelLarge().copyWith(
                color: MYColors.textPrimaryColor,
              ),
            ),
          ],
        ],
      ),
      backgroundColor: MYColors.warningColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusLg),
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: MYColors.textPrimaryColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      dismissDirection: DismissDirection.horizontal,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccessSnackBar({
    required BuildContext context,
    required String title,
    String message = '',
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: MYAppTextStyles.labelLarge().copyWith(
              color: MYColors.snackbarTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (message.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              message,
              style: MYAppTextStyles.labelLarge().copyWith(
                color: MYColors.snackbarTextColor,
              ),
            ),
          ],
        ],
      ),
      backgroundColor: MYColors.successColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusLg),
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: MYColors.snackbarTextColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      dismissDirection: DismissDirection.horizontal,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showCustomToast({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: duration,
        backgroundColor: MYColors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MySizes.borderRadiusXxl),
            color: MYColors.black.withOpacity(0.7),
          ),
          child: Center(
            child: Text(
              message,
              style: MYAppTextStyles.labelLarge(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}