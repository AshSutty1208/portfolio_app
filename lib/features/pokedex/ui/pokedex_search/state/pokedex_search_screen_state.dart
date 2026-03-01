import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'pokedex_search_screen_state.mapper.dart';

@MappableClass()
class PokedexSearchScreenState with PokedexSearchScreenStateMappable {
  const PokedexSearchScreenState({
    this.searchQuery = '',
    this.pokemonSearchResults = const [],
    this.getPokemonSearchApiStatus = ApiStatusEnum.notStarted,
  });

  final String searchQuery;
  final List<PokemonDetail> pokemonSearchResults;
  final ApiStatusEnum getPokemonSearchApiStatus;
}
