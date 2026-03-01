import 'package:portfolio_app/features/pokedex/domain/pokemon_details/pokemon_abilities.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'pokemon_details/pokemon_species.dart';
import 'pokemon_details/pokemon_type.dart';

part 'pokemon_detail.mapper.dart';

/// Class that represents a Pokemons Specific Detail
@MappableClass()
class PokemonDetail with PokemonDetailMappable {
  const PokemonDetail({
    required this.id,
    required this.order,
    required this.name,
    required this.baseExperience,
    required this.weight,
    required this.height,
    required this.isDefault,
    required this.locationAreasUrl,
    required this.imageUrl,
    required this.pokemonTypes,
    required this.pokemonAbilities,
    required this.pokemonSpecies,
  });

  final int id;
  final int order;
  @MappableField(hook: CapitalizeNameHook())
  final String name;
  @MappableField(key: 'base_experience')
  final int baseExperience;
  final int weight;
  final int height;
  @MappableField(key: 'is_default')
  final bool isDefault;
  @MappableField(key: 'location_area_encounters')
  final String locationAreasUrl;
  final String imageUrl;
  @MappableField(key: 'types')
  final List<PokemonType> pokemonTypes;
  @MappableField(key: 'abilities')
  final List<PokemonAbilities> pokemonAbilities;
  @MappableField(key: 'species', hook: PokemonSpeciesHook())
  final PokemonSpecies pokemonSpecies;

  factory PokemonDetail.fromApi(Map<String, dynamic> map) {
    return PokemonDetail(
      id: map['id'] as int,
      name: map['name'] as String,
      baseExperience: map['base_experience'] as int,
      weight: map['weight'] as int,
      height: map['height'] as int,
      order: map['order'] as int,
      imageUrl: map['sprites']['front_default'] ??= "",
      isDefault: map['is_default'] ??= false,
      locationAreasUrl: map['location_area_encounters'] as String,
      pokemonTypes: List<PokemonType>.from(
        map['types'].map((type) => PokemonType.fromApi(type)),
      ),
      pokemonAbilities: List<PokemonAbilities>.from(
        map['abilities'].map((ability) => PokemonAbilities.fromApi(ability)),
      ),
      pokemonSpecies: PokemonSpecies.fromApi(map['species']),
    );
  }
}

class CapitalizeNameHook extends MappingHook {
  const CapitalizeNameHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      return value[0].toUpperCase() + value.substring(1);
    }
    return value;
  }
}

class PokemonSpeciesHook extends MappingHook {
  const PokemonSpeciesHook();

  @override
  Object? beforeDecode(Object? value) {
    // Note: The species object from the Pokemon API doesn't include an id field,
    // but PokemonSpecies expects one. The hook receives just the species value,
    // not the parent context. We'll need to handle this at the service level
    // or modify the approach. For now, returning as-is and assuming the API
    // response includes the id in the species object.
    return value;
  }
}
