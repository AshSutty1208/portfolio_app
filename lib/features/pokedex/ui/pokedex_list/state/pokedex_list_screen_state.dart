import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'pokedex_list_screen_state.mapper.dart';

@MappableClass()
class PokedexListScreenState with PokedexListScreenStateMappable {
  const PokedexListScreenState({
    this.pokemon = const [],
    this.getPokemonApiStatus = ApiStatusEnum.notStarted,
    this.currentPage = 1,
  });

  final List<PokemonDetail> pokemon;
  final ApiStatusEnum getPokemonApiStatus;
  final int currentPage;

  static const fromMap = PokedexListScreenStateMapper.fromMap;
  static const fromJson = PokedexListScreenStateMapper.fromJson;
}
