import 'package:cubit_movies/presentation/router/arguments.dart';
import 'package:cubit_movies/presentation/ui/movie/movie_cubit.dart';
import 'package:cubit_movies/presentation/ui/movie/movie_state.dart';
import 'package:cubit_movies/presentation/ui/movie/widgets/movie_overview.dart';
import 'package:cubit_movies/presentation/ui/movie/widgets/movie_title.dart';
import 'package:cubit_movies/shared/constants/app_values.dart';
import 'package:cubit_movies/shared/constants/strings_keys.dart';
import 'package:cubit_movies/shared/styles/widgets.dart';
import 'package:cubit_movies/shared/widgets/app_network_image.dart';
import 'package:cubit_movies/shared/widgets/app_progress.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDesktop extends StatelessWidget {
  final MovieArguments arguments;
  final MovieCubit movieCubit;

  const MovieDesktop({
    Key? key,
    required this.arguments,
    required this.movieCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(StringsKeys.movie.tr()),
        bottom: appBarDivider(),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: arguments.movieId.toString() + arguments.posterPath.toString() + AppValues.heroPoster,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 38,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 640,
                          maxWidth: 480,
                        ),
                        child: AppNetworkImage(
                          url: AppValues.imageUrl + (arguments.posterPath ?? ''),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 24,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildMovieTitle(
                            context: context,
                            title: arguments.title,
                            voteAverage: arguments.voteAverage,
                          ),
                          BlocBuilder<MovieCubit, MovieState>(
                            bloc: movieCubit,
                            builder: (BuildContext context, MovieState state) {
                              if (state is MovieLoadingState) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 36),
                                  child: AppProgress(),
                                );
                              } else if (state is MovieErrorState) {
                                return const AppErrorWidget();
                              } else if (state is MovieLoadedState) {
                                return Flexible(
                                  child: buildMovieOverview(
                                    context: context,
                                    overview: state.movie.overview,
                                  ),
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
