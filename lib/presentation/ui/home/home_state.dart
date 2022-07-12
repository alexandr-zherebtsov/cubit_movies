import 'package:cubit_movies/domain/models/filter_model.dart';
import 'package:cubit_movies/domain/responses/movies_response.dart';
import 'package:cubit_movies/shared/core/base/pagination_scroll_controller.dart';

abstract class HomeState {}

class HomeEmptyState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeMoviesLoadingState extends HomeState {}

class HomePaginationState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<MoviesResponse> movies;
  PaginationScrollController moviesSC;
  FilterModel? filterModel;
  bool paginationLoader;

  HomeLoadedState({
    required this.movies,
    required this.moviesSC,
    required this.filterModel,
    required this.paginationLoader,
  });
}
