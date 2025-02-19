import 'package:flutter/material.dart';

class MYAppShapes {
  // Fully Rounded Corners
  static RoundedRectangleBorder roundedAll(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  // Top Rounded Corners
  static RoundedRectangleBorder roundedTop(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
    );
  }

  // Bottom Rounded Corners
  static RoundedRectangleBorder roundedBottom(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
    );
  }

  // Left Rounded Corners
  static RoundedRectangleBorder roundedLeft(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(radius)),
    );
  }

  // Right Rounded Corners
  static RoundedRectangleBorder roundedRight(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(radius)),
    );
  }

  // Circle Shape (For Buttons, Avatars, etc.)
  static CircleBorder circle() {
    return const CircleBorder();
  }

  // Rectangle Shape (For Buttons, Cards)
  static RoundedRectangleBorder rectangle({double radius = 8.0}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  // Stadium Shape (Used for Rounded Buttons, Chips)
  static StadiumBorder stadium() {
    return const StadiumBorder();
  }

  // Beveled Rectangle Shape (Used for Different Styles)
  static BeveledRectangleBorder beveled({double radius = 8.0}) {
    return BeveledRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
