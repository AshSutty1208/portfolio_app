import 'package:portfolio_app/features/chat/ui/chat_list_screen.dart';
import 'package:portfolio_app/features/pokedex/domain/pokemon_detail.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_list/pokedex_list_screen.dart';
import 'package:portfolio_app/features/pokedex/ui/pokedex_search/pokedex_search_screen.dart';
import 'package:portfolio_app/features/pokedex/ui/pokemon_detail/pokemon_detail_screen.dart';
import 'package:portfolio_app/features/tab_view_holder.dart';
import 'package:portfolio_app/features/timeline/ui/timeline_list/timeline_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final parentNavigatorKey = GlobalKey<NavigatorState>();

/// Tabbed shell keys
final timelineShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'timelineShell',
);
final pokedexShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'pokedexShell',
);
final chatShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'chatShell',
);

final baseRouter = GoRouter(
  initialLocation: RoutePaths.timeline,
  navigatorKey: parentNavigatorKey,
  // observers: [SentryNavigatorObserver()],
  routes: [
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: parentNavigatorKey,
      builder: (context, state, navShell) {
        return TabViewHolder(navShell);
      },
      branches: [
        /// Timeline view
        StatefulShellBranch(
          navigatorKey: timelineShellNavigatorKey,
          routes: [
            GoRoute(
              path: RoutePaths.timeline,
              builder: (context, state) {
                return const TimelineScreen();
              },
            ),
          ],
        ),

        /// Discover view
        StatefulShellBranch(
          navigatorKey: pokedexShellNavigatorKey,
          routes: [
            GoRoute(
              path: RoutePaths.pokedex,
              builder: (context, state) {
                return const PokedexListScreen();
              },
              routes: [
                GoRoute(
                  path: RoutePaths.pokedexSearch,
                  builder: (context, state) {
                    return const PokedexSearchScreen();
                  },
                ),
                GoRoute(
                  parentNavigatorKey: parentNavigatorKey,
                  path: RoutePaths.pokemonDetail,
                  builder: (context, state) {
                    return PokemonDetailScreen(
                      pokemon: state.extra as PokemonDetail,
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        /// Event view
        StatefulShellBranch(
          navigatorKey: chatShellNavigatorKey,
          routes: [
            GoRoute(
              path: RoutePaths.chat,
              builder: (context, state) {
                return const ChatListScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

/// These routes are used in tandem with context.push(^)/context.go(^)
class NavigationRoutes {
  /// THIS SCREEN IS THE BASE NAVIGATED SCREEN
  static const String splash = '/';

  /// Dashboard routes
  static const String timeline = '/timeline';
  static const String pokedex = '/pokedex';
  static const String chat = '/chat';

  static const String pokemonDetail = '/pokedex/pokemon_detail';
  static const String pokedexSearch = '/pokedex/pokedex_search';
}

/// These routes are used in routePaths found inside {example}_router files
class RoutePaths {
  /// THIS SCREEN IS THE BASE NAVIGATED SCREEN
  static const String splash = '/';

  /// verified dashboard routes
  static const String timeline = '/timeline';
  static const String pokedex = '/pokedex';
  static const String chat = '/chat';

  static const String pokemonDetail = 'pokemon_detail';
  static const String pokedexSearch = 'pokedex_search';
}
