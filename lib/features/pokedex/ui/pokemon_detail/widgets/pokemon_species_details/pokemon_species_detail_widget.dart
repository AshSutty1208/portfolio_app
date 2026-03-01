import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/loaders/pokeball_loading_spinner.dart';
import 'package:portfolio_app/extensions.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_species.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/pokemon_detail_screen_view_model.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_species_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonSpeciesDetailWidget extends BaseConsumerWidget {
  final PokemonSpecies pokemonSpecies;

  const PokemonSpeciesDetailWidget(this.pokemonSpecies, {super.key});

  Widget getCharacterLineItem(
    String leftText,
    String rightText,
    AppTheme appTheme,
  ) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: appTheme.colours.coreBlackLightWhiteDark,
            width: 1,
          ),
        ),
        color: appTheme.colours.coreOrange,
        child: Container(
          constraints: BoxConstraints(minHeight: 100),
          child: Center(
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    leftText,
                    textAlign: TextAlign.center,
                    style: appTheme.textStyles.captionBold.copyWith(
                      color: appTheme.colours.coreWhiteLightBlackDark,
                    ),
                  ),
                ),
                Text(
                  rightText.capitalize().replaceAll("-", " "),
                  textAlign: TextAlign.center,
                  style: appTheme.textStyles.label2.copyWith(
                    color: appTheme.colours.coreBlackLightWhiteDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSpeciesDetailWidget(
    BuildContext context,
    AppTheme appTheme,
    PokemonSpeciesDetail? pokemonSpeciesDetail,
  ) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getCharacterLineItem(
          "Growth Rate",
          pokemonSpeciesDetail?.growthRate ?? "None",
          appTheme,
        ),
        getCharacterLineItem(
          "Shape",
          pokemonSpeciesDetail?.shape ?? "None",
          appTheme,
        ),
        getCharacterLineItem(
          "Capture Rate",
          pokemonSpeciesDetail?.captureRate.toString() ?? "None",
          appTheme,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    final pokemonSpeciesDetail = ref
        .watch(pokemonDetailScreenViewModelProvider)
        .pokemonSpeciesDetail;

    final getPokemonSpeciesApiStatus = ref
        .watch(pokemonDetailScreenViewModelProvider)
        .getPokemonSpeciesApiStatus;

    return switch (getPokemonSpeciesApiStatus) {
      ApiStatusEnum.success => getSpeciesDetailWidget(
        context,
        appTheme,
        pokemonSpeciesDetail,
      ),
      ApiStatusEnum.loading => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: PokeballLoadingSpinner(
            text: "Fetching Pokemon Species Details...",
          ),
        ),
      ),
      ApiStatusEnum.failed => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: Text(
            "Failed to fetch Pokemon Characteristics.",
            style: appTheme.textStyles.label1.copyWith(
              color: appTheme.colours.coreBrickRed,
            ),
          ),
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
