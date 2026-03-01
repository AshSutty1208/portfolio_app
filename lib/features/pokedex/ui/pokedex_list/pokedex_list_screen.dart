import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/loaders/no_data_loader.dart';
import 'package:portfolio_app/base_widgets/loaders/pokeball_loading_spinner.dart';
import 'package:portfolio_app/base_widgets/navigation/app_bar.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_list/pokedex_list_screen_view_model.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_list/widgets/pokedex_list_item.dart';
import 'package:portfolio_app/routes/base_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PokedexListScreen extends BaseConsumerStatefulWidget {
  const PokedexListScreen({super.key});

  @override
  BaseConsumerState<PokedexListScreen> createState() =>
      _PokedexListScreenState();
}

class _PokedexListScreenState extends BaseConsumerState<PokedexListScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(pokedexListScreenViewModelProvider.notifier).init();
    });

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 100) {
        if (ref.read(pokedexListScreenViewModelProvider).getPokemonApiStatus !=
            ApiStatusEnum.loading) {
          ref
              .read(pokedexListScreenViewModelProvider.notifier)
              .hitBottomOfList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(pokedexListScreenViewModelProvider).pokemon;
    final getPokemonApiStatus = ref
        .watch(pokedexListScreenViewModelProvider)
        .getPokemonApiStatus;

    return Scaffold(
      appBar: baseAppBar(
        context,
        ref,
        appTheme,
        Text('Pokedex', style: appTheme.textStyles.label2),
        actions: [
          IconButton(
            onPressed: () {
              context.push(NavigationRoutes.pokedexSearch);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: pokemonList.isNotEmpty
            ? _buildPokedexList(pokemonList, getPokemonApiStatus)
            : switch (getPokemonApiStatus) {
                ApiStatusEnum.notStarted => SizedBox.shrink(),
                ApiStatusEnum.loading => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PokeballLoadingSpinner(
                        text: 'Loading Pokedex...',
                        size: 48,
                      ),
                    ],
                  ),
                ),
                ApiStatusEnum.success => _buildPokedexList(
                  pokemonList,
                  getPokemonApiStatus,
                ),
                ApiStatusEnum.failed => Center(
                  child: Column(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NoDataLoader(),
                      Text(
                        'Pokedex Unavailable',
                        style: appTheme.textStyles.label2,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            ref
                                .read(
                                  pokedexListScreenViewModelProvider.notifier,
                                )
                                .onRefresh();
                          },
                          child: Text(
                            'Try Again',
                            style: appTheme.textStyles.label1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              },
      ),
    );
  }

  Widget _buildPokedexList(
    List<PokemonDetail> pokemonList,
    ApiStatusEnum getPokemonApiStatus,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RefreshIndicator(
              onRefresh: () async {
                ref
                    .read(pokedexListScreenViewModelProvider.notifier)
                    .onRefresh();
              },
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                    visible: getPokemonApiStatus == ApiStatusEnum.loading,
                    sliver: SliverToBoxAdapter(
                      child: const Center(child: PokeballLoadingSpinner()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
