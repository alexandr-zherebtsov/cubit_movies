import 'package:cubit_movies/presentation/router/arguments.dart';
import 'package:cubit_movies/presentation/router/routes.dart';
import 'package:cubit_movies/presentation/ui/home/home_screen.dart';
import 'package:cubit_movies/presentation/ui/movie/movie_screen.dart';
import 'package:cubit_movies/presentation/ui/settings/settings_screen.dart';
import 'package:cubit_movies/presentation/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.movie,
        builder: (BuildContext context, GoRouterState state) {
          return MovieScreen(
            arguments: state.extra as MovieArguments,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (BuildContext context, GoRouterState state) {
          return SettingsScreen();
        },
      ),
    ],
  );
}
