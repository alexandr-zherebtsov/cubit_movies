import 'package:cubit_movies/domain/responses/genre_response.dart';

class FilterModel {
  String year;
  List<GenreResponse> selectedGenres;

  FilterModel({
    required this.year,
    required this.selectedGenres,
  });
}
