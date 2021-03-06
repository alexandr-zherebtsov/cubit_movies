import 'package:cubit_movies/domain/responses/genre_response.dart';

abstract class FilterState {}

class FilterEmptyState extends FilterState {}

class FilterErrorState extends FilterState {}

class FilterLoadingState extends FilterState {}

class FilterLoadedState extends FilterState {
  String year;
  List<GenreResponse> genres;
  List<GenreResponse> selectedGenres;

  FilterLoadedState({
    required this.year,
    required this.genres,
    required this.selectedGenres,
  });
}
