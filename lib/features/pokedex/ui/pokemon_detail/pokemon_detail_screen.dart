import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/fade_in.dart';
import 'package:portfolio_app/extensions.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_type.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/pokemon_detail_screen_view_model.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/widgets/pokedex_detail_toolbar_topcontent_widget.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/widgets/pokemon_abilities/pokemon_abilities_widget.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/widgets/pokemon_characteristics%20/pokemon_characteristic_widget.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/widgets/pokemon_species_details/pokemon_species_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PokemonDetailScreen extends BaseConsumerStatefulWidget {
  const PokemonDetailScreen({super.key, required this.pokemon});

  final PokemonDetail pokemon;

  @override
  BaseConsumerState<PokemonDetailScreen> createState() =>
      _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends BaseConsumerState<PokemonDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(pokemonDetailScreenViewModelProvider.notifier)
          .init(widget.pokemon);
    });
  }

  List<Widget> getPokemonTypeWidgets() {
    List<Widget> widgets = [];

    for (PokemonType pokemonType in widget.pokemon.pokemonTypes) {
      widgets.add(
        FadeIn(
          fadeInDuration: 400,
          child: Container(
            margin: const EdgeInsets.only(right: 4, left: 4, top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: pokemonType.color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: appTheme.colours.coreWhiteLightBlackDark,
                width: 0.5,
              ),
            ),
            width: 72,
            child: Center(
              child: Text(
                pokemonType.name.capitalize().replaceAll("-", " "),
                style: appTheme.textStyles.captionBold.copyWith(
                  color: appTheme.colours.coreWhiteLightBlackDark,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: appTheme.colours.coreOrange,
            toolbarHeight: 40,
            iconTheme: IconThemeData(color: Colors.white),
            expandedHeight: MediaQuery.of(context).padding.top + 220,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: PokedexDetailToolbarTopContentWidget(
                pokemonDetail: widget.pokemon,
              ),
              titlePadding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              centerTitle: true,
              title: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: appTheme.colours.coreOrange,
                  constraints: const BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: 48,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeIn(
                        fadeInDuration: 500,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            widget.pokemon.name.capitalize(),
                            textAlign: TextAlign.center,
                            style: appTheme.textStyles.label2.copyWith(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Contained inside of a single item list
          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return Column(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(),
                  PokemonCharacteristicWidget(),
                  PokemonSpeciesDetailsWidget(
                    pokemonSpecies: widget.pokemon.pokemonSpecies,
                  ),
                  PokemonAbilitiesWidget(widget.pokemon.pokemonSpecies),
                  // Extra padding to push the bottom of the screen
                  SizedBox(height: 40),
                ],
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  }
}
