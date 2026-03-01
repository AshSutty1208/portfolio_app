import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/app_theme/app_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// using these base states for provider based widgets allows us to have the
/// apps theme readily available in each of the widgets

abstract class BaseConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  AppTheme get appTheme => ref.watch(appThemeStateProvider);
}

abstract class BaseConsumerStatefulWidget extends ConsumerStatefulWidget {
  const BaseConsumerStatefulWidget({super.key});

  @override
  // ignore: no_logic_in_create_state
  ConsumerState createState();
}

abstract class BaseConsumerWidget extends ConsumerStatefulWidget {
  const BaseConsumerWidget({super.key});

  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme);

  @override
  ConsumerState createState() => _BaseConsumerState();
}

class _BaseConsumerState extends ConsumerState<BaseConsumerWidget> {
  @override
  WidgetRef get ref => context as WidgetRef;

  AppTheme get appTheme => ref.watch(appThemeStateProvider);

  @override
  Widget build(BuildContext context) {
    return widget.build(context, ref, appTheme);
  }
}
