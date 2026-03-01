import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabNavigationDestination extends BaseConsumerWidget {
  const TabNavigationDestination({
    required this.tabLabel,
    required this.icon,
    required this.isSelected,
    super.key,
  });

  final String tabLabel;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Visibility(
          visible: isSelected,
          child: Container(
            height: 4,
            width: double.infinity,
            color: appTheme.colours.coreOrange,
          ),
        ),
        Flexible(
          child: NavigationDestination(
            label: '',
            icon: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(
                          icon,
                          color: appTheme.colours.coreBlackLightWhiteDark,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    tabLabel,
                    style: appTheme.textStyles.label1.copyWith(
                      color: appTheme.colours.coreBlackLightWhiteDark,
                    ),
                  ),
                ],
              ),
            ),
            selectedIcon: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(icon, color: appTheme.colours.coreOrange),
                      ),
                    ),
                  ),
                  Text(tabLabel, style: appTheme.textStyles.label1),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
