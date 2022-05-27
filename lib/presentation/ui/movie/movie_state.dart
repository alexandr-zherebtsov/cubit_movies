import 'package:cubit_movies/domain/responses/movie_response.dart';

abstract class MovieState {}

class MovieEmptyState extends MovieState {}

class MovieErrorState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MoviePaginationState extends MovieState {}

class MovieLoadedState extends MovieState {
  MovieResponse movie;

  MovieLoadedState({
    required this.movie,
  });
}
