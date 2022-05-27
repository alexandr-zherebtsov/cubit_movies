import 'package:cubit_movies/data/remote/location_service.dart';
import 'package:cubit_movies/presentation/di/locator.dart';
import 'package:cubit_movies/presentation/ui/splash/splash_cubit.dart';
import 'package:cubit_movies/presentation/ui/splash/splash_state.dart';
import 'package:cubit_movies/shared/constants/strings_keys.dart';
import 'package:cubit_movies/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final LocationService _locationService = locator<LocationService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      bloc: SplashCubit(
        context: context,
        locationService: _locationService,
      ),
      builder: (BuildContext context, SplashState state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.movie_filter_outlined,
                color: AppColors.pinkAccent,
                size: 260.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  StringsKeys.movies.tr(),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
