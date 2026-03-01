// ignore_for_file: unused_import

import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/base_api/base_service.dart';
import 'package:portfolio_app/features/pokedex/domain/pokedex_repository.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_list/state/pokedex_list_screen_state.dart';
import 'package:portfolio_app/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokedex_list_screen_view_model.g.dart';

@riverpod
class PokedexListScreenViewModel extends _$PokedexListScreenViewModel {
  PokedexRepository get _pokedexRepository =>
      ref.watch(pokedexRepositoryProvider);

  @override
  PokedexListScreenState build() => PokedexListScreenState();

  void init() {
    _callGetPokemon(state.currentPage);
  }

  Future<ApiResult?> _callGetPokemon(int page) async {
    try {
      state = state.copyWith(getPokemonApiStatus: ApiStatusEnum.loading);
      final result = await _pokedexRepository.getPokemon(page);

      if (result is Success<List<PokemonDetail>>) {
        logDebug('Pokedex List Screen View Model', 'Result: ${result.data}');

        final newPokemon = [...state.pokemon, ...result.data];
        newPokemon.sort((a, b) => a.order.compareTo(b.order));

        state = state.copyWith(
          currentPage: page,
          pokemon: [...state.pokemon, ...result.data],
          getPokemonApiStatus: ApiStatusEnum.success,
        );
      } else if (result is Failed<List<PokemonDetail>>) {
        state = state.copyWith(getPokemonApiStatus: ApiStatusEnum.failed);
      }
    } catch (e, s) {
      logException('Pokedex List Screen View Model', e, stackTrace: s);
      state = state.copyWith(getPokemonApiStatus: ApiStatusEnum.failed);
    }

    return null;
  }

  void onRefresh() {
    state = state.copyWith(
      currentPage: 1,
      pokemon: [],
      getPokemonApiStatus: ApiStatusEnum.notStarted,
    );
    _callGetPokemon(1);
  }

  void hitBottomOfList() {
    _callGetPokemon(state.currentPage + 1);
  }
}
