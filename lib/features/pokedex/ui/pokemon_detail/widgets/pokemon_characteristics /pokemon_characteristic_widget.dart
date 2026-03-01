import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/loaders/pokeball_loading_spinner.dart';
import 'package:portfolio_app/extensions.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_characteristic_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_species.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/pokemon_detail_screen_view_model.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_species_detail.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/widgets/pokemon_characteristics%20/pokemon_characteristic_stat_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonCharacteristicWidget extends BaseConsumerWidget {
  const PokemonCharacteristicWidget({super.key});

  Widget getHighestStatWidget(String highestStat, AppTheme appTheme) {
    return Card(
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
        constraints: BoxConstraints(minHeight: 72),
        child: Center(
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  "Highest Stat",
                  textAlign: TextAlign.center,
                  style: appTheme.textStyles.label1.copyWith(
                    color: appTheme.colours.coreWhiteLightBlackDark,
                  ),
                ),
              ),
              Text(
                highestStat.capitalize().replaceAll("-", " "),
                textAlign: TextAlign.center,
                style: appTheme.textStyles.label2.copyWith(
                  color: appTheme.colours.coreBlackLightWhiteDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCharacteristicsDetailWidget(
    BuildContext context,
    AppTheme appTheme,
    PokemonCharacteristicDetail? pokemonCharacteristicDetail,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pokemon Characteristics",
            textAlign: TextAlign.left,
            style: appTheme.textStyles.label2.copyWith(
              color: appTheme.colours.coreBlackLightWhiteDark,
            ),
          ),
          Text(
            pokemonCharacteristicDetail?.description.replaceAll("\n", " ") ??
                "None",
            style: appTheme.textStyles.body1,
          ),
          SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: appTheme.colours.coreBlackLightWhiteDark,
                width: 1,
              ),
            ),
            color: appTheme.colours.coreCoralRed,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 10.0,
              ),
              child: Column(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...pokemonCharacteristicDetail?.possibleValues.indexed
                          .map(
                            (value) => PokemonCharacteristicStatBar(
                              stat: value.$2,
                              index: value.$1,
                            ),
                          )
                          .toList() ??
                      [],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    final pokemonCharacteristicDetail = ref
        .watch(pokemonDetailScreenViewModelProvider)
        .pokemonCharacteristicDetail;

    final getPokemonSpeciesApiStatus = ref
        .watch(pokemonDetailScreenViewModelProvider)
        .getPokemonSpeciesApiStatus;

    return switch (getPokemonSpeciesApiStatus) {
      ApiStatusEnum.success => getCharacteristicsDetailWidget(
        context,
        appTheme,
        pokemonCharacteristicDetail,
      ),
      ApiStatusEnum.loading => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: PokeballLoadingSpinner(
            text: "Fetching Pokemon Characteristics...",
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
