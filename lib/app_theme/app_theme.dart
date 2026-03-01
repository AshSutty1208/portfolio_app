import 'package:portfolio_app/app_theme/app_theme_colours.dart';
import 'package:portfolio_app/app_theme/app_theme_text_styles.dart';
import 'package:flutter/material.dart';

export 'app_theme_colours.dart';

/// This is the base class for the app theme.
abstract class AppTheme {
  late final bool isLight;

  ThemeData get materialTheme;

  AppThemeColours get colours;

  AppThemeTextStyles get textStyles;
}

class AppThemeDark implements AppTheme {
  @override
  ThemeData get materialTheme => ThemeData(
    scaffoldBackgroundColor: colours.scaffoldBg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colours.coreBlackLightWhiteDark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colours.coreOrange,
      foregroundColor: colours.coreBlackLightWhiteDark,
      iconTheme: IconThemeData(color: colours.coreBlackLightWhiteDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colours.coreOrange,
        foregroundColor: colours.coreBlackLightWhiteDark,
      ),
    ),
    iconTheme: IconThemeData(color: colours.coreOrange),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: colours.coreOrange,
      iconColor: colours.coreOrange,
      suffixIconColor: colours.coreOrange,
      hintStyle: TextStyle(color: colours.coreBlackLightWhiteDark),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colours.coreOrange),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: colours.coreBlackLightWhiteDark),
      bodyMedium: TextStyle(color: colours.coreBlackLightWhiteDark),
      bodySmall: TextStyle(color: colours.coreBlackLightWhiteDark),
      labelLarge: TextStyle(color: colours.coreBlackLightWhiteDark),
      labelMedium: TextStyle(color: colours.coreBlackLightWhiteDark),
      labelSmall: TextStyle(color: colours.coreBlackLightWhiteDark),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colours.scaffoldBg,
      surfaceTintColor: colours.scaffoldBg,
    ),
  );

  @override
  bool isLight = false;

  @override
  AppThemeColours get colours => const AppDarkColours();

  @override
  AppThemeTextStyles get textStyles =>
      const AppDarkTextStyles(AppDarkColours());
}

class AppThemeLight implements AppTheme {
  @override
  bool isLight = true;

  @override
  ThemeData get materialTheme => ThemeData(
    scaffoldBackgroundColor: colours.scaffoldBg,
    colorScheme: ColorScheme.fromSeed(seedColor: colours.coreCoralRed),
  );

  @override
  AppThemeColours get colours => const AppLightColours();

  @override
  AppThemeTextStyles get textStyles =>
      const AppLightTextStyles(AppLightColours());
}
