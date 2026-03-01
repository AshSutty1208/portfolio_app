// ignore_for_file: unused_import

import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/base_api/base_service.dart';
import 'package:portfolio_app/features/pokedex/domain/pokedex_repository.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_abilities.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_ability_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_characteristic_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_species_detail.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_list/state/pokedex_list_screen_state.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/state/pokemon_detail_screen_state.dart';
import 'package:portfolio_app/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_detail_screen_view_model.g.dart';

@riverpod
class PokemonDetailScreenViewModel extends _$PokemonDetailScreenViewModel {
  PokedexRepository get _pokedexRepository =>
      ref.watch(pokedexRepositoryProvider);

  @override
  PokemonDetailScreenState build() => PokemonDetailScreenState();

  void init(PokemonDetail pokemonDetail) {
    _callGetPokemonSpecies(pokemonDetail.pokemonSpecies.url);
    _callGetPokemonAbilitiesDetail(pokemonDetail.pokemonAbilities);
    _callGetPokemonCharacteristicDetails(pokemonDetail.id);
  }

  Future<ApiResult?> _callGetPokemonSpecies(String speciesUrl) async {
    try {
      state = state.copyWith(getPokemonSpeciesApiStatus: ApiStatusEnum.loading);
      final result = await _pokedexRepository.getPokemonSpecies(speciesUrl);

      if (result is Success<PokemonSpeciesDetail>) {
        state = state.copyWith(
          getPokemonSpeciesApiStatus: ApiStatusEnum.success,
          pokemonSpeciesDetail: result.data,
        );
      } else if (result is Failed) {
        state = state.copyWith(
          getPokemonSpeciesApiStatus: ApiStatusEnum.failed,
        );
      }
    } catch (e, s) {
      logException('Pokemon Detail Screen View Model', e, stackTrace: s);
      state = state.copyWith(getPokemonSpeciesApiStatus: ApiStatusEnum.failed);
    }

    return null;
  }

  Future<ApiResult?> _callGetPokemonAbilitiesDetail(
    List<PokemonAbilities> pokemonAbilities,
  ) async {
    try {
      state = state.copyWith(getPokemonAbilityApiStatus: ApiStatusEnum.loading);
      final result = await _pokedexRepository.getPokemonAbilitiesDetail(
        pokemonAbilities,
      );

      if (result is Success<List<PokemonAbilityDetail>>) {
        state = state.copyWith(
          getPokemonAbilityApiStatus: ApiStatusEnum.success,
          pokemonAbilityDetails: result.data,
        );
      } else if (result is Failed) {
        state = state.copyWith(
          getPokemonAbilityApiStatus: ApiStatusEnum.failed,
        );
      }
    } catch (e, s) {
      logException('Pokemon Detail Screen View Model', e, stackTrace: s);
      state = state.copyWith(getPokemonAbilityApiStatus: ApiStatusEnum.failed);
    }

    return null;
  }

  Future<ApiResult?> _callGetPokemonCharacteristicDetails(int pokemonId) async {
    try {
      state = state.copyWith(
        getPokemonCharacteristicApiStatus: ApiStatusEnum.loading,
      );
      final result = await _pokedexRepository.getPokemonCharacteristicDetails(
        pokemonId,
      );

      if (result is Success<PokemonCharacteristicDetail>) {
        state = state.copyWith(
          getPokemonCharacteristicApiStatus: ApiStatusEnum.success,
          pokemonCharacteristicDetail: result.data,
        );
      } else if (result is Failed) {
      } else if (result is Failed) {
        state = state.copyWith(
          getPokemonCharacteristicApiStatus: ApiStatusEnum.failed,
        );
      }

      return null;
    } catch (e, s) {
      logException('Pokemon Detail Screen View Model', e, stackTrace: s);
      state = state.copyWith(
        getPokemonCharacteristicApiStatus: ApiStatusEnum.failed,
      );
    }

    return null;
  }
}
