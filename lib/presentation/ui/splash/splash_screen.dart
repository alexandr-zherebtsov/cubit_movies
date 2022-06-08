import 'package:cubit_movies/presentation/router/routes.dart';
import 'package:cubit_movies/presentation/ui/splash/splash_cubit.dart';
import 'package:cubit_movies/presentation/ui/splash/splash_state.dart';
import 'package:cubit_movies/shared/constants/strings_keys.dart';
import 'package:cubit_movies/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      bloc: SplashCubit(
        goHome: () => context.go(AppRoutes.home),
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
