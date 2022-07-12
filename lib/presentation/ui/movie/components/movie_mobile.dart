import 'package:cubit_movies/presentation/di/di.dart';
import 'package:cubit_movies/presentation/router/arguments.dart';
import 'package:cubit_movies/presentation/ui/movie/movie_cubit.dart';
import 'package:cubit_movies/presentation/ui/movie/movie_state.dart';
import 'package:cubit_movies/presentation/ui/movie/widgets/movie_overview.dart';
import 'package:cubit_movies/presentation/ui/movie/widgets/movie_title.dart';
import 'package:cubit_movies/shared/constants/app_values.dart';
import 'package:cubit_movies/shared/styles/colors.dart';
import 'package:cubit_movies/shared/styles/widgets.dart';
import 'package:cubit_movies/shared/widgets/app_network_image.dart';
import 'package:cubit_movies/shared/widgets/app_progress.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MovieMobile extends StatelessWidget {
  final MovieArguments arguments;

  MovieMobile({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final MovieCubit _movieCubit = getIt.get<MovieCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <SliverAppBar>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height / 1.4,
              floating: true,
              pinned: false,
              shadowColor: AppColors.transparent,
              iconTheme: Theme.of(context).iconTheme.copyWith(
                color: AppColors.white,
              ),
              leading: IconButton(
                onPressed: context.pop,
                icon: DecoratedIcon(
                  Icons.adaptive.arrow_back,
                  shadows: [
                    BoxShadow(
                      blurRadius: 30,
                      color: Theme.of(context).primaryColor.withOpacity(0.76),
                    ),
                  ],
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: arguments.movieId.toString() + arguments.posterPath.toString() + AppValues.heroPoster,
                  child: AppNetworkImage(
                    url: AppValues.imageUrl + (arguments.posterPath ?? ''),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildMovieTitle(
                  context: context,
                  title: arguments.title,
                  voteAverage: arguments.voteAverage,
                ),
                buildDivider(),
                BlocBuilder<MovieCubit, MovieState>(
                  bloc: _movieCubit..getMovie(arguments.movieId),
                  builder: (BuildContext context, MovieState state) {
                    if (state is MovieLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 36),
                        child: AppProgress(),
                      );
                    } else if (state is MovieErrorState) {
                      return const AppErrorWidget();
                    } else if (state is MovieLoadedState) {
                      return buildMovieOverview(
                        context: context,
                        overview: state.movie.overview,
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
      ),
    );
  }
}
