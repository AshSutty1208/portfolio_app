import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/loaders/pokeball_loading_spinner.dart';
import 'package:portfolio_app/extensions.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokedexListItem extends BaseConsumerWidget {
  const PokedexListItem({super.key, required this.pokemon});

  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    return IntrinsicHeight(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: appTheme.colours.coreBlackLightWhiteDark,
            width: 1,
          ),
        ),
        color: appTheme.colours.corePaleMint,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                pokemon.pokemonTypes.first.backgroundImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.network(
                      width: 80,
                      height: 80,
                      pokemon.imageUrl,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return PokeballLoadingSpinner();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      pokemon.name.capitalize(),
                      style: appTheme.textStyles.label1.copyWith(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
