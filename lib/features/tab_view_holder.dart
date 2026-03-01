import 'package:portfolio_app/app_theme/app_theme_dimensions.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/navigation/tab_navigation_destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Root view of the whole app
class TabViewHolder extends BaseConsumerStatefulWidget {
  const TabViewHolder(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  BaseConsumerState createState() => _TabViewHolderState();
}

class _TabViewHolderState extends BaseConsumerState<TabViewHolder> {
  @override
  void initState() {
    super.initState();
  }

  void _goBranch(WidgetRef ref, int index) async {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.navigationShell),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: appTheme.colours.coreGreyMedium),
          ),
        ),
        child: NavigationBar(
          selectedIndex: widget.navigationShell.currentIndex,
          indicatorColor: Colors.transparent,
          backgroundColor: appTheme.colours.coreWhiteLightBlackDark,
          surfaceTintColor: appTheme.colours.coreBlackLightWhiteDark,
          shadowColor: Colors.transparent,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          height: AppThemeDimensions.tabBarHeight,
          indicatorShape: const RoundedRectangleBorder(),
          destinations: _buildNavigationDestinations(),
          onDestinationSelected: (index) => _goBranch(ref, index),
        ),
      ),
    );
  }

  List<TabNavigationDestination> _buildNavigationDestinations() {
    return [
      TabNavigationDestination(
        tabLabel: 'Timeline',
        icon: Icons.timeline,
        isSelected: widget.navigationShell.currentIndex == 0,
      ),
      TabNavigationDestination(
        tabLabel: 'Pokedex',
        icon: Icons.pets,
        isSelected: widget.navigationShell.currentIndex == 1,
      ),
      TabNavigationDestination(
        tabLabel: 'Chat',
        icon: Icons.chat,
        isSelected: widget.navigationShell.currentIndex == 2,
      ),
    ];
  }
}
