import 'dart:io';

import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/fade_in.dart';
import 'package:portfolio_app/extensions.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:flutter/material.dart';

class PokedexDetailToolbarTopContentWidget extends BaseConsumerStatefulWidget {
  final PokemonDetail pokemonDetail;

  const PokedexDetailToolbarTopContentWidget({
    super.key,
    required this.pokemonDetail,
  });

  @override
  BaseConsumerState<PokedexDetailToolbarTopContentWidget> createState() =>
      _PokedexDetailToolbarTopContentWidgetState();
}

class _PokedexDetailToolbarTopContentWidgetState
    extends BaseConsumerState<PokedexDetailToolbarTopContentWidget> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.pokemonDetail.pokemonTypes.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    widget.pokemonDetail.pokemonTypes[index].backgroundImage,
                    fit: BoxFit.contain,
                    scale: 1.5,
                  ),
                  Positioned(
                    bottom: 82,
                    left: 24,
                    child: FadeIn(
                      fadeInDuration: 600,
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                widget.pokemonDetail.pokemonTypes[index].color,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: appTheme.colours.coreBlackLightWhiteDark,
                              width: 1,
                            ),
                          ),
                          width: 120,
                          height: 40,
                          child: Center(
                            child: Text(
                              widget.pokemonDetail.pokemonTypes[index].name
                                  .capitalize()
                                  .replaceAll("-", " "),
                              style: appTheme.textStyles.label1.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Platform.isIOS ? 92 : 70,
                    right: Platform.isIOS ? 40 : 50,
                    child: Image.network(
                      widget.pokemonDetail.imageUrl,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 84, right: 16),
                child: PageIndicator(
                  pageController: _pageController,
                  itemCount: widget.pokemonDetail.pokemonTypes.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageIndicator extends StatefulWidget {
  const PageIndicator({
    super.key,
    required this.pageController,
    required this.itemCount,
  });

  final PageController pageController;
  final int itemCount;

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_onPageChanged);
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      currentIndex = widget.pageController.page?.round() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount <= 1) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.itemCount,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index
                ? Colors.white
                : Colors.white.withOpacity(0.5),
            border: Border.all(color: Colors.black87, width: 0.5),
          ),
        ),
      ),
    );
  }
}
