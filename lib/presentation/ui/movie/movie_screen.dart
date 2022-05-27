import 'package:cubit_movies/data/remote/movies_service.dart';
import 'package:cubit_movies/presentation/di/locator.dart';
import 'package:cubit_movies/presentation/router/arguments.dart';
import 'package:cubit_movies/presentation/ui/movie/components/movie_desktop.dart';
import 'package:cubit_movies/presentation/ui/movie/components/movie_mobile.dart';
import 'package:cubit_movies/presentation/ui/movie/movie_cubit.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  final MovieArguments arguments;

  const MovieScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late final MovieCubit _movieCubit;
  final MoviesService _moviesService = locator<MoviesService>();

  @override
  void initState() {
    _movieCubit = MovieCubit(
      movieId: widget.arguments.movieId,
      moviesService: _moviesService,
    );
    super.initState();
  }

  @override
  void dispose() {
    _movieCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 800) {
          return MovieMobile(
            arguments: widget.arguments,
            movieCubit: _movieCubit,
          );
        } else {
          return MovieDesktop(
            arguments: widget.arguments,
            movieCubit: _movieCubit,
          );
        }
      },
    );
  }
}
