import 'package:portfolio_app/app_theme/app_theme.dart' show AppTheme;
import 'package:flutter/material.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class NoDataLoader extends BaseConsumerWidget {
  const NoDataLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    return Lottie.asset('assets/no_data.json', width: 250, height: 250);
  }
}
