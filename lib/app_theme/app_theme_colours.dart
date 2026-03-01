import 'package:flutter/material.dart';

class PokemonTypeColours {
  const PokemonTypeColours._();

  static Color get pokemonTypeColorNormal => const Color(0xFFA8A77A);
  static Color get pokemonTypeColorFire => const Color(0xFFEE8130);
  static Color get pokemonTypeColorWater => const Color(0xFF6390F0);
  static Color get pokemonTypeColorElectric => const Color(0xFFF7D02C);
  static Color get pokemonTypeColorGrass => const Color(0xFF7AC74C);
  static Color get pokemonTypeColorIce => const Color(0xFF96D9D6);
  static Color get pokemonTypeColorFighting => const Color(0xFFC22E28);
  static Color get pokemonTypeColorPoison => const Color(0xFFA33EA1);
  static Color get pokemonTypeColorGround => const Color(0xFFE2BF65);
  static Color get pokemonTypeColorFlying => const Color(0xFFA98FF3);
  static Color get pokemonTypeColorPsychic => const Color(0xFFF95587);
  static Color get pokemonTypeColorBug => const Color(0xFFA6B91A);
  static Color get pokemonTypeColorRock => const Color(0xFFB6A136);
  static Color get pokemonTypeColorGhost => const Color(0xFF735797);
  static Color get pokemonTypeColorDragon => const Color(0xFF6F35FC);
  static Color get pokemonTypeColorDark => const Color(0xFF705746);
  static Color get pokemonTypeColorSteel => const Color(0xFFB7B7CE);
  static Color get pokemonTypeColorFairy => const Color(0xFFD685AD);
}

@immutable
abstract class AppThemeColours {
  const AppThemeColours();

  Color get coreBlackLightWhiteDark => const Color(0xFF111111);
  Color get coreWhiteLightBlackDark => const Color.fromARGB(255, 255, 255, 255);
  Color get black70 => const Color(0xB3111111);

  Color get coreGreyDarkest => const Color(0xFF343434);

  Color get coreGreyDarker => const Color(0xFF999999);

  Color get coreGreyDark => const Color(0xFFBBBBBB);

  Color get coreGreyMedium => const Color(0xFFDDDDDD);

  Color get coreGreyLight => const Color(0xFFF1F1F1);

  /// portfolioApp colours
  Color get coreOrange => const Color(0xFFF05226);
  Color get coreCoralRed => const Color(0xFFFDD8CF);
  Color get coreBrickRed => const Color(0xFFBD3B27);
  Color get coreRustRed => const Color(0xFF6B1300);

  Color get corePaleMint => const Color(0xFFE2F7E6);
  Color get coreSageGreen => const Color(0xFFC1E0C7);
  Color get coreFreshGreen => const Color(0xFF84CC8F);
  Color get coreForestGreen => const Color(0xFF345136);

  /// Cards
  Color get scaffoldBg => const Color.fromARGB(255, 249, 249, 249);
}

/// App colors if the app is in dark mode
class AppDarkColours extends AppThemeColours {
  const AppDarkColours();

  @override
  /// Override black with white
  Color get coreBlackLightWhiteDark => Colors.white;

  @override
  Color get coreWhiteLightBlackDark => Colors.black;

  @override
  Color get scaffoldBg => const Color.fromARGB(255, 46, 46, 46);

  @override
  Color get coreOrange => coreBrickRed;

  @override
  Color get coreCoralRed => coreRustRed;

  @override
  Color get corePaleMint => coreForestGreen;

  @override
  Color get coreSageGreen => corePaleMint;
}

/// App colors if the app is in light mode
class AppLightColours extends AppThemeColours {
  const AppLightColours();
}
