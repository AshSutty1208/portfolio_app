import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/app_theme/app_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

PreferredSizeWidget baseAppBar(
  BuildContext context,
  WidgetRef ref,
  AppTheme appTheme,
  Widget? title, {
  List<Widget> actions = const [],
}) {
  return AppBar(
    animateColor: true,
    scrolledUnderElevation: 0,
    title: title,
    actions: [
      ...actions,
      IconButton(
        onPressed: () {
          if (ref.read(appThemeStateProvider).isLight) {
            ref.read(appThemeStateProvider.notifier).setDarkTheme();
          } else {
            ref.read(appThemeStateProvider.notifier).setLightTheme();
          }
        },
        icon: Icon(Icons.colorize_outlined),
      ),
    ],
  );
}
