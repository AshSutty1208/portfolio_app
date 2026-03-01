import 'package:portfolio_app/app_theme/app_theme_colours.dart';
import 'package:flutter/material.dart';

/// Text styles used in the navigation bar
abstract class AppThemeTextStyles {
  const AppThemeTextStyles(this.appThemeColours);

  final AppThemeColours appThemeColours;

  TextStyle get label1;

  TextStyle get label2;

  TextStyle get body2;

  TextStyle get body1;

  TextStyle get caption;

  TextStyle get captionBold;
}

/// App text style if the app is in light mode
class AppLightTextStyles extends AppThemeTextStyles {
  const AppLightTextStyles(super.appThemeColours);

  @override
  TextStyle get caption => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get label2 => const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get body1 => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get body2 => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get captionBold => const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get label1 => const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);
}

/// App text style if the app is in dark mode
class AppDarkTextStyles extends AppThemeTextStyles {
  const AppDarkTextStyles(super.appThemeColours);

  @override
  TextStyle get caption => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get label2 => const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get body1 => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get body2 => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get captionBold => const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);

  @override
  TextStyle get label1 => const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.5,
  ).copyWith(color: appThemeColours.coreBlackLightWhiteDark);
}
