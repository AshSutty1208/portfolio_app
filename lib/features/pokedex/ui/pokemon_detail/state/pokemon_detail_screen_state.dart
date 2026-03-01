import 'package:portfolio_app/base_api/api_status_enum.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_ability_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_characteristic_detail.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_species_detail.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'pokemon_detail_screen_state.mapper.dart';

@MappableClass()
class PokemonDetailScreenState with PokemonDetailScreenStateMappable {
  const PokemonDetailScreenState({
    this.getPokemonSpeciesApiStatus = ApiStatusEnum.notStarted,
    this.pokemonSpeciesDetail,
    this.getPokemonAbilityApiStatus = ApiStatusEnum.notStarted,
    this.pokemonAbilityDetails,
    this.getPokemonCharacteristicApiStatus = ApiStatusEnum.notStarted,
    this.pokemonCharacteristicDetail,
  });

  final ApiStatusEnum getPokemonSpeciesApiStatus;
  final PokemonSpeciesDetail? pokemonSpeciesDetail;
  final ApiStatusEnum getPokemonAbilityApiStatus;
  final List<PokemonAbilityDetail>? pokemonAbilityDetails;
  final ApiStatusEnum getPokemonCharacteristicApiStatus;
  final PokemonCharacteristicDetail? pokemonCharacteristicDetail;

  static const fromMap = PokemonDetailScreenStateMapper.fromMap;
  static const fromJson = PokemonDetailScreenStateMapper.fromJson;
}
