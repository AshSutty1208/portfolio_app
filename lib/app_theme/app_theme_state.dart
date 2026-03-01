import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_state.g.dart';

@riverpod
class AppThemeState extends _$AppThemeState {
  @override
  AppTheme build() => AppThemeLight();

  void setLightTheme() => state = AppThemeLight();

  void setDarkTheme() => state = AppThemeDark();
}
