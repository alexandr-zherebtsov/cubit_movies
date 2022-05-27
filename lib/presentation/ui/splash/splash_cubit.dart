import 'package:cubit_movies/data/remote/location_service.dart';
import 'package:cubit_movies/presentation/router/routes.dart';
import 'package:cubit_movies/presentation/ui/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashCubit extends Cubit<SplashState> {
  final BuildContext context;
  final LocationService locationService;

  SplashCubit({
    required this.context,
    required this.locationService,
  }) : super(SplashLoadingState()) {
    determineLocation();
  }

  Future<void> determineLocation() async {
    await locationService.determineLocation();
    context.go(AppRoutes.home);
  }
}
