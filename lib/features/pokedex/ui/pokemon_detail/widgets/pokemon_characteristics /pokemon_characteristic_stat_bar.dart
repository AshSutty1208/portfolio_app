import 'dart:math';

import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:flutter/material.dart';

class PokemonCharacteristicStatBar extends BaseConsumerStatefulWidget {
  final int stat;
  final int index;

  const PokemonCharacteristicStatBar({
    super.key,
    required this.stat,
    required this.index,
  });

  @override
  BaseConsumerState<PokemonCharacteristicStatBar> createState() =>
      _PokemonCharacteristicStatBarState();
}

class _PokemonCharacteristicStatBarState
    extends BaseConsumerState<PokemonCharacteristicStatBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation = Tween<double>(
      begin: 0,
      end: getRandomStatValue() / 100,
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == 0) {
      return SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                getStatText(widget.index),
                style: appTheme.textStyles.captionBold,
              ),
            ),
            Flexible(
              child: LinearProgressIndicator(
                value: _animation.value,
                color: Colors.red,
                backgroundColor: Colors.grey,
                minHeight: 10,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        );
      },
    );
  }

  String getStatText(int index) {
    switch (index) {
      case 1:
        return "Hit Points";
      case 2:
        return "Attack";
      case 3:
        return "Defense";
      case 4:
        return "Speed";
      case 5:
        return "Sp. Attack";
      case 6:
        return "Sp. Defense";
    }
    return "Unknown";
  }

  int getRandomStatValue() {
    return Random().nextInt(100);
  }
}
