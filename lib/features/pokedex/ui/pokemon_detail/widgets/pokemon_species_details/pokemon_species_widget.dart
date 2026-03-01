import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_species.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/pokemon_detail_screen_view_model.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/widgets/pokemon_species_details/pokemon_species_detail_widget.dart';
import 'package:flutter/material.dart';

class PokemonSpeciesDetailsWidget extends BaseConsumerStatefulWidget {
  final PokemonSpecies pokemonSpecies;

  const PokemonSpeciesDetailsWidget({super.key, required this.pokemonSpecies});

  @override
  BaseConsumerState<PokemonSpeciesDetailsWidget> createState() =>
      _PokemonCharacteristicsWidgetState();
}

class _PokemonCharacteristicsWidgetState
    extends BaseConsumerState<PokemonSpeciesDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final pokemonSpeciesDetail = ref
        .watch(pokemonDetailScreenViewModelProvider)
        .pokemonSpeciesDetail;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            "Pokemon Species Details",
            textAlign: TextAlign.left,
            style: appTheme.textStyles.label2.copyWith(
              color: appTheme.colours.coreBlackLightWhiteDark,
            ),
          ),
          Text(
            pokemonSpeciesDetail?.description.replaceAll("\n", " ") ?? "None",
            style: appTheme.textStyles.body1,
          ),
          PokemonSpeciesDetailWidget(widget.pokemonSpecies),
        ],
      ),
    );
  }
}
