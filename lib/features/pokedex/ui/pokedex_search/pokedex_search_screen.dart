import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/loaders/no_data_loader.dart';
import 'package:portfolio_app/base_widgets/loaders/pokeball_loading_spinner.dart';
import 'package:portfolio_app/base_widgets/navigation/app_bar.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_list/pokedex_list_screen_view_model.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_list/widgets/pokedex_list_item.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_search/pokedex_search_screen_view_model.dart';
import 'package:portfolio_app/routes/base_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PokedexSearchScreen extends BaseConsumerStatefulWidget {
  const PokedexSearchScreen({super.key});

  @override
  BaseConsumerState<PokedexSearchScreen> createState() =>
      _PokedexSearchScreenState();
}

class _PokedexSearchScreenState extends BaseConsumerState<PokedexSearchScreen> {
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void dispose() {
    _searchQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonSearchResults = ref
        .watch(pokedexSearchScreenViewModelProvider)
        .pokemonSearchResults;
    final getPokemonSearchApiStatus = ref
        .watch(pokedexSearchScreenViewModelProvider)
        .getPokemonSearchApiStatus;

    return Scaffold(
      appBar: baseAppBar(
        context,
        ref,
        appTheme,
        Text('Pokedex Search', style: appTheme.textStyles.label2),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flexible(
                child: TextField(
                  controller: _searchQueryController,
                  decoration: InputDecoration(
                    hintText: 'Enter a Pokemon name or ID',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSubmitted: (value) {
                    ref
                        .read(pokedexSearchScreenViewModelProvider.notifier)
                        .searchPokemon(value);
                  },
                  onTap: () {
                    _searchQueryController.clear();
                    ref
                        .read(pokedexSearchScreenViewModelProvider.notifier)
                        .clearResults();
                  },
                ),
              ),
            ),
            Flexible(
              child: pokemonSearchResults.isNotEmpty
                  ? _buildPokedexSearchList(
                      pokemonSearchResults,
                      getPokemonSearchApiStatus,
                    )
                  : switch (getPokemonSearchApiStatus) {
                      ApiStatusEnum.notStarted => SizedBox.shrink(),
                      ApiStatusEnum.loading => Padding(
                        padding: const EdgeInsets.only(top: 48.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PokeballLoadingSpinner(
                              text: 'Loading Search Results...',
                              size: 48,
                            ),
                          ],
                        ),
                      ),
                      ApiStatusEnum.success => _buildPokedexSearchList(
                        pokemonSearchResults,
                        getPokemonSearchApiStatus,
                      ),
                      ApiStatusEnum.failed => Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NoDataLoader(),
                          Text(
                            'No results found',
                            style: appTheme.textStyles.label2,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(
                                      pokedexSearchScreenViewModelProvider
                                          .notifier,
                                    )
                                    .searchPokemon(_searchQueryController.text);
                              },
                              child: Text(
                                'Try Again',
                                style: appTheme.textStyles.label1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokedexSearchList(
    List<PokemonDetail> pokemonList,
    ApiStatusEnum getPokemonSearchApiStatus,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              slivers: [
                SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 150,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          NavigationRoutes.pokemonDetail,
                          extra: pokemonList[index],
                        );
                      },
                      child: PokedexListItem(pokemon: pokemonList[index]),
                    );
                  },
                  itemCount: pokemonList.length,
                ),
                SliverVisibility(
                  visible: getPokemonSearchApiStatus == ApiStatusEnum.loading,
                  sliver: SliverToBoxAdapter(
                    child: const Center(child: PokeballLoadingSpinner()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
