import 'package:portfolio_app/app_theme/app_theme_state.dart';
import 'package:portfolio_app/routes/base_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageAssets {
  static const String pokemonBgGrassland = 'assets/pokemon_bg_grassland.png';
  static const String pokemonBgDarkCavern = 'assets/pokemon_bg_dark_cavern.png';
  static const String pokemonBgDesert = 'assets/pokemon_bg_desert.png';
  static const String pokemonBgElectricField =
      'assets/pokemon_bg_electricfield.png';
  static const String pokemonBgFairytale = 'assets/pokemon_bg_fairytale.png';
  static const String pokemonBgFireField = 'assets/pokemon_bg_firefield.png';
  static const String pokemonBgForest = 'assets/pokemon_bg_forest.png';
  static const String pokemonBgRockyField = 'assets/pokemon_bg_rockyfield.png';
  static const String pokemonBgUnderwater = 'assets/pokemon_bg_underwater.png';
  static const String pokemonBgWasteland = 'assets/pokemon_bg_wasteland.png';
  static const String pokemonBgWaterSurface =
      'assets/pokemon_bg_water_surface.png';
  static const String pokemonBgIcyField = 'assets/pokemon_bg_icyfield.png';
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Pre-cache any assets that are used to decrease the time to first paint
    precacheImage(AssetImage(ImageAssets.pokemonBgGrassland), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgDarkCavern), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgDesert), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgElectricField), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgFairytale), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgFireField), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgForest), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgRockyField), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgUnderwater), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgWasteland), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgWaterSurface), context);
    precacheImage(AssetImage(ImageAssets.pokemonBgIcyField), context);

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return MaterialApp.router(
          title: 'Portfolio App',
          routerConfig: baseRouter,
          theme: ref.watch(appThemeStateProvider).materialTheme,
          darkTheme: ref.watch(appThemeStateProvider).materialTheme,
        );
      },
    );
  }
}
