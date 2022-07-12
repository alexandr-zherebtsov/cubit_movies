import 'dart:developer';

import 'package:cubit_movies/data/remote/repositories/filter_repository.dart';
import 'package:cubit_movies/domain/responses/genre_response.dart';
import 'package:cubit_movies/shared/constants/app_values.dart';
import 'package:cubit_movies/shared/core/network/dio_manager.dart';
import 'package:cubit_movies/shared/utils/utils.dart';

class FilterRepositoryImpl extends FilterRepository {
  final DioManager _dio;
  FilterRepositoryImpl(this._dio);

  @override
  Future<List<GenreResponse>> getGenres() async {
    List<GenreResponse> res = <GenreResponse>[];
    try {
      return await _dio.get(
        'genre/movie/list',
        parameters: {
          'api_key': AppValues.apiKey,
          'language': getLangCode(),
        },
      ).then((response) {
        res = (response.data['genres'] as List).map((e) {
          return GenreResponse.fromJson(e);
        }).toList();
        return res;
      });
    } catch (e) {
      log(e.toString());
      return res;
    }
  }
}
