import 'package:cubit_movies/shared/constants/app_values.dart';
import 'package:cubit_movies/shared/utils/utils.dart';

class MovieRequest {
  String? apiKey;
  String? language;
  int? movieId;

  MovieRequest({
    this.apiKey,
    this.language,
    this.movieId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['api_key'] = apiKey ?? AppValues.apiKey;
    data['language'] = language ?? getLangCode();
    return data;
  }
}
