import 'package:portfolio_app/base_api/base_service.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_abilities.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_ability_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_characteristic_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_species_detail.dart';
import 'package:portfolio_app/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokedex_service.g.dart';

@riverpod
PokedexService pokedexService(Ref ref) {
  return PokedexService(ref);
}

class PokedexService extends BaseService {
  final Ref ref;

  PokedexService(this.ref);

  /// page is converted to limit 1*100
  Future<ApiResult<List<PokemonDetail>>> getPokemon(int page) async {
    try {
      logDebug(
        'PokedexService',
        'Endpoint: ${Endpoint.pokemon}?limit=20&offset=${(page - 1) * 20}',
      );
      final response = await getDio().get(
        "${Endpoint.pokemon}?limit=20&offset=${(page - 1) * 20}",
      );

      final result = await ApiResult.fromResponse<List<PokemonDetail>>(
        response,
        (dynamic data) async {
          if (data is! Map<String, dynamic> ||
              data['results'] is! List<dynamic>) {
            throw Exception('Invalid data format');
          }

          final List<PokemonDetail> pokemonList = [];
          for (final pokemon in data['results']) {
            final response = await getDio().get(pokemon['url']);
            final pokemonDetail = PokemonDetail.fromApi(response.data);
            pokemonList.add(pokemonDetail);
          }

          return pokemonList;
        },
      );

      return result;
    } catch (e, stackTrace) {
      logException(
        'PokedexService',
        'Error in getPokemon: $e',
        stackTrace: stackTrace,
      );
      return Failed(e.toString());
    }
  }

  Future<ApiResult<List<PokemonDetail>>> getPokemonViaSearch(
    String searchQuery,
  ) async {
    try {
      logDebug('PokedexService', 'Endpoint: ${Endpoint.pokemon}$searchQuery');
      final response = await getDio().get("${Endpoint.pokemon}$searchQuery");

      final result = await ApiResult.fromResponse<List<PokemonDetail>>(
        response,
        (dynamic data) async {
          final List<PokemonDetail> pokemonList = [];

          pokemonList.add(PokemonDetail.fromApi(data));

          return pokemonList;
        },
      );

      return result;
    } catch (e, stackTrace) {
      logException(
        'PokedexService',
        'Error in getPokemon: $e',
        stackTrace: stackTrace,
      );
      return Failed(e.toString());
    }
  }

  Future<ApiResult<PokemonSpeciesDetail>> getPokemonSpecies(
    String speciesUrl,
  ) async {
    try {
      logDebug('PokedexService', 'Endpoint: $speciesUrl');
      final response = await getDio().get(speciesUrl);
      final result = await ApiResult.fromResponse<PokemonSpeciesDetail>(
        response,
        (dynamic data) async {
          if (data is! Map<String, dynamic>) {
            throw Exception('Invalid data format');
          }

          return PokemonSpeciesDetail.fromApi(data);
        },
      );
      return result;
    } catch (e, stackTrace) {
      logException(
        'PokedexService',
        'Error in getPokemonSpecies: $e',
        stackTrace: stackTrace,
      );
      return Failed(e.toString());
    }
  }

  Future<ApiResult<PokemonCharacteristicDetail>>
  getPokemonCharacteristicDetails(int pokemonId) async {
    try {
      final response = await getDio().get(
        "${Endpoint.pokemonCharacteristic}$pokemonId",
      );
      final result = await ApiResult.fromResponse<PokemonCharacteristicDetail>(
        response,
        (dynamic data) async {
          if (data is! Map<String, dynamic>) {
            throw Exception('Invalid data format');
          }

          return PokemonCharacteristicDetail.fromApi(data);
        },
      );
      return result;
    } catch (e, stackTrace) {
      logException(
        'PokedexService',
        'Error in getPokemonCharacteristicDetails: $e',
        stackTrace: stackTrace,
      );
      return Failed(e.toString());
    }
  }

  Future<ApiResult<List<PokemonAbilityDetail>>> getPokemonAbilitiesDetail(
    List<PokemonAbilities> pokemonAbilities,
  ) async {
    try {
      final List<PokemonAbilityDetail> pokemonAbilityDetails = [];

      /// TODO: Change this to individual API calls for each ability
      for (final pokemonAbility in pokemonAbilities) {
        logDebug('PokedexService', 'Endpoint: ${pokemonAbility.abilityUrl}');
        final response = await getDio().get(pokemonAbility.abilityUrl);
        final pokemonAbilityDetail = PokemonAbilityDetail.fromApi(
          response.data,
        );
        pokemonAbilityDetails.add(pokemonAbilityDetail);
      }

      return Success(pokemonAbilityDetails);
    } catch (e, stackTrace) {
      logException(
        'PokedexService',
        'Error in getPokemonAbility: $e',
        stackTrace: stackTrace,
      );
      return Failed(e.toString());
    }
  }
}
