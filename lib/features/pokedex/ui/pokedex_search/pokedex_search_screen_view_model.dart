// ignore_for_file: unused_import

import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/base_api/base_service.dart';
import 'package:portfolio_app/features/pokedex/domain/pokedex_repository.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_list/state/pokedex_list_screen_state.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_search/state/pokedex_search_screen_state.dart';
import 'package:portfolio_app/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokedex_search_screen_view_model.g.dart';

@riverpod
class PokedexSearchScreenViewModel extends _$PokedexSearchScreenViewModel {
  PokedexRepository get _pokedexRepository =>
      ref.watch(pokedexRepositoryProvider);

  @override
  PokedexSearchScreenState build() => PokedexSearchScreenState();

  Future<ApiResult?> searchPokemon(String searchQuery) async {
    try {
      state = state.copyWith(getPokemonSearchApiStatus: ApiStatusEnum.loading);
      final result = await _pokedexRepository.getPokemonViaSearch(searchQuery);

      if (result is Success<List<PokemonDetail>>) {
        logDebug('Pokedex Search Screen View Model', 'Result: ${result.data}');

        state = state.copyWith(
          pokemonSearchResults: result.data,
          getPokemonSearchApiStatus: ApiStatusEnum.success,
        );
      } else if (result is Failed<List<PokemonDetail>>) {
        state = state.copyWith(getPokemonSearchApiStatus: ApiStatusEnum.failed);
      }
    } catch (e, s) {
      logException('Pokedex Search Screen View Model', e, stackTrace: s);
      state = state.copyWith(getPokemonSearchApiStatus: ApiStatusEnum.failed);
    }

    return null;
  }

  void clearResults() {
    state = state.copyWith(
      pokemonSearchResults: [],
      getPokemonSearchApiStatus: ApiStatusEnum.notStarted,
    );
  }
}
