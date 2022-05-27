import 'dart:developer';

import 'package:cubit_movies/domain/request/filter_request.dart';
import 'package:cubit_movies/domain/request/movie_request.dart';
import 'package:cubit_movies/domain/request/movies_query_request.dart';
import 'package:cubit_movies/domain/request/movies_request.dart';
import 'package:cubit_movies/domain/responses/movie_response.dart';
import 'package:cubit_movies/domain/responses/movies_response.dart';
import 'package:cubit_movies/presentation/di/locator.dart';
import 'package:cubit_movies/shared/core/network/dio_manager.dart';

class MoviesService {
  final DioManager _dio = locator<DioManager>();

  Future<List<MoviesResponse>> getMovies(MoviesRequest parameters) async {
    List<MoviesResponse> res = <MoviesResponse>[];
    try {
      return await _dio.get(
        'discover/movie',
        parameters: parameters.toJson(),
      ).then((response) {
        res = (response.data['results'] as List).map((e) {
          return MoviesResponse.fromJson(e);
        }).toList();
        return res;
      });
    } catch (e) {
      log(e.toString());
      return res;
    }
  }

  Future<List<MoviesResponse>> getMoviesByQuery(MoviesQueryRequest parameters) async {
    List<MoviesResponse> res = <MoviesResponse>[];
    try {
      return await _dio.get(
        'search/movie',
        parameters: parameters.toJson(),
      ).then((response) {
        res = (response.data['results'] as List).map((e) {
          return MoviesResponse.fromJson(e);
        }).toList();
        return res;
      });
    } catch (e) {
      log(e.toString());
      return res;
    }
  }

  Future<List<MoviesResponse>> getMoviesByFilter(FilterRequest filter) async {
    List<MoviesResponse> res = <MoviesResponse>[];
    try {
      return await _dio.get(
        'discover/movie',
        parameters: filter.toJson(),
      ).then((response) {
        res = (response.data['results'] as List).map((e) {
          return MoviesResponse.fromJson(e);
        }).toList();
        return res;
      });
    } catch (e) {
      log(e.toString());
      return res;
    }
  }

  Future<MovieResponse?> getMovie(MovieRequest parameters) async {
    try {
      return await _dio.get(
        'movie/${parameters.movieId}',
        parameters: parameters.toJson(),
      ).then((response) {
        return MovieResponse.fromJson(response.data);
      });
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
