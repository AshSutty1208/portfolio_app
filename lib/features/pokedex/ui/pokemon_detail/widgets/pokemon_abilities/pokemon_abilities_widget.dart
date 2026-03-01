import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/loaders/pokeball_loading_spinner.dart';
import 'package:portfolio_app/extensions.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_ability_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_species.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/pokemon_detail_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonAbilitiesWidget extends BaseConsumerWidget {
  final PokemonSpecies pokemonSpecies;

  const PokemonAbilitiesWidget(this.pokemonSpecies, {super.key});

  Widget getAbilityLineItem(
    String abilityName,
    String abilityEffectEntry,
    AppTheme appTheme,
  ) {
    return Flexible(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Center(
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    abilityName,
                    textAlign: TextAlign.center,
                    style: appTheme.textStyles.label1.copyWith(
                      color: appTheme.colours.coreWhiteLightBlackDark,
                    ),
                  ),
                ),
                Text(
                  abilityEffectEntry.capitalize().replaceAll('\n', ' '),
                  textAlign: TextAlign.center,
                  style: appTheme.textStyles.captionBold.copyWith(
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

  Widget getAbilitiesDetailsWidget(
    BuildContext context,
    AppTheme appTheme,
    List<PokemonAbilityDetail>? pokemonAbilityDetails,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pokemon Abilities",
            textAlign: TextAlign.left,
            style: appTheme.textStyles.label2.copyWith(
              color: appTheme.colours.coreBlackLightWhiteDark,
            ),
          ),
          Text(
            "The Abilities of this Pokemon",
            textAlign: TextAlign.left,
            style: appTheme.textStyles.body1.copyWith(
              color: appTheme.colours.coreBlackLightWhiteDark,
            ),
          ),
          ...pokemonAbilityDetails
                  ?.map(
                    (pokemonAbilityDetail) => getAbilityLineItem(
                      pokemonAbilityDetail.name,
                      pokemonAbilityDetail.effectEntry,
                      appTheme,
                    ),
                  )
                  .toList() ??
              [],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    final pokemonAbilityDetail = ref
        .watch(pokemonDetailScreenViewModelProvider)
        .pokemonAbilityDetails;

    final getPokemonAbilityApiStatus = ref
        .watch(pokemonDetailScreenViewModelProvider)
        .getPokemonAbilityApiStatus;

    return switch (getPokemonAbilityApiStatus) {
      ApiStatusEnum.success => getAbilitiesDetailsWidget(
        context,
        appTheme,
        pokemonAbilityDetail,
      ),
      ApiStatusEnum.loading => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: PokeballLoadingSpinner(text: "Fetching Pokemon Abilities..."),
        ),
      ),
      ApiStatusEnum.failed => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: Text(
            "Failed to fetch Pokemon Abilities.",
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
