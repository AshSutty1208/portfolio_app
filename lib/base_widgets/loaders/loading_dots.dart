import 'package:portfolio_app/app_theme/app_theme.dart' show AppTheme;
import 'package:flutter/material.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class LoadingDots extends BaseConsumerWidget {
  const LoadingDots({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    return Lottie.asset('assets/loading_dots.json', width: 40, height: 40);
  }
}
