import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/main.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'pokemon_type.mapper.dart';

@MappableClass()
class PokemonType with PokemonTypeMappable {
  const PokemonType({
    required this.url,
    required this.name,
    required this.color,
    required this.backgroundImage,
  });

  final String url;
  final String name;
  final Color color;
  final String backgroundImage;

  factory PokemonType.fromApi(Map<String, dynamic> map) {
    Map<String, dynamic> typeJson = map['type'];

    String name = typeJson['name'] as String;

    return PokemonType(
      url: map['url'] ??= "",
      name: name,
      color: getColor(name),
      backgroundImage: getBackgroundImage(name),
    );
  }

  static Color getColor(String name) {
    switch (name.toLowerCase()) {
      case "normal":
        return PokemonTypeColours.pokemonTypeColorNormal;
      case "fire":
        return PokemonTypeColours.pokemonTypeColorFire;
      case "water":
        return PokemonTypeColours.pokemonTypeColorWater;
      case "electric":
        return PokemonTypeColours.pokemonTypeColorElectric;
      case "grass":
        return PokemonTypeColours.pokemonTypeColorGrass;
      case "ice":
        return PokemonTypeColours.pokemonTypeColorIce;
      case "fighting":
        return PokemonTypeColours.pokemonTypeColorFighting;
      case "poison":
        return PokemonTypeColours.pokemonTypeColorPoison;
      case "ground":
        return PokemonTypeColours.pokemonTypeColorGround;
      case "flying":
        return PokemonTypeColours.pokemonTypeColorFlying;
      case "psychic":
        return PokemonTypeColours.pokemonTypeColorPsychic;
      case "bug":
        return PokemonTypeColours.pokemonTypeColorBug;
      case "rock":
        return PokemonTypeColours.pokemonTypeColorRock;
      case "ghost":
        return PokemonTypeColours.pokemonTypeColorGhost;
      case "dragon":
        return PokemonTypeColours.pokemonTypeColorDragon;
      case "dark":
        return PokemonTypeColours.pokemonTypeColorDark;
      case "steel":
        return PokemonTypeColours.pokemonTypeColorSteel;
      case "fairy":
        return PokemonTypeColours.pokemonTypeColorFairy;

      default:
        return PokemonTypeColours.pokemonTypeColorNormal;
    }
  }

  static String getBackgroundImage(String name) {
    switch (name.toLowerCase()) {
      case "normal":
        return ImageAssets.pokemonBgGrassland;
      case "fire":
        return ImageAssets.pokemonBgFireField;
      case "water":
        return ImageAssets.pokemonBgWaterSurface;
      case "electric":
        return ImageAssets.pokemonBgElectricField;
      case "grass":
        return ImageAssets.pokemonBgGrassland;
      case "ice":
        return ImageAssets.pokemonBgIcyField;
      case "fighting":
        return ImageAssets.pokemonBgGrassland;
      case "poison":
        return ImageAssets.pokemonBgWasteland;
      case "ground":
        return ImageAssets.pokemonBgRockyField;
      case "flying":
        return ImageAssets.pokemonBgForest;
      case "psychic":
        return ImageAssets.pokemonBgFairytale;
      case "bug":
        return ImageAssets.pokemonBgForest;
      case "rock":
        return ImageAssets.pokemonBgRockyField;
      case "ghost":
        return ImageAssets.pokemonBgDarkCavern;
      case "dragon":
        return ImageAssets.pokemonBgFireField;
      case "dark":
        return ImageAssets.pokemonBgDarkCavern;
      case "steel":
        return ImageAssets.pokemonBgRockyField;
      case "fairy":
        return ImageAssets.pokemonBgFairytale;

      default:
        return ImageAssets.pokemonBgGrassland;
    }
  }
}
