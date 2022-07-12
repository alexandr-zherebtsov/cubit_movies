import 'package:cubit_movies/domain/responses/genre_response.dart';

abstract class FilterRepository {
  Future<List<GenreResponse>> getGenres();
}
