import 'package:cubit_movies/domain/request/filter_request.dart';
import 'package:cubit_movies/domain/request/movie_request.dart';
import 'package:cubit_movies/domain/request/movies_query_request.dart';
import 'package:cubit_movies/domain/request/movies_request.dart';
import 'package:cubit_movies/domain/responses/movie_response.dart';
import 'package:cubit_movies/domain/responses/movies_response.dart';

abstract class MoviesRepository {
  Future<List<MoviesResponse>> getMovies(final MoviesRequest parameters);

  Future<List<MoviesResponse>> getMoviesByQuery(final MoviesQueryRequest parameters);

  Future<List<MoviesResponse>> getMoviesByFilter(final FilterRequest filter);

  Future<MovieResponse?> getMovie(final MovieRequest parameters);
}
