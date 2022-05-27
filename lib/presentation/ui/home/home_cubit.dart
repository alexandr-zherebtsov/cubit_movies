import 'dart:async';
import 'dart:developer';

import 'package:cubit_movies/data/remote/movies_service.dart';
import 'package:cubit_movies/domain/models/filter_model.dart';
import 'package:cubit_movies/domain/request/filter_request.dart';
import 'package:cubit_movies/domain/request/movies_query_request.dart';
import 'package:cubit_movies/domain/request/movies_request.dart';
import 'package:cubit_movies/domain/responses/genre_response.dart';
import 'package:cubit_movies/domain/responses/movies_response.dart';
import 'package:cubit_movies/presentation/ui/home/home_enums.dart';
import 'package:cubit_movies/presentation/ui/home/home_state.dart';
import 'package:cubit_movies/shared/core/base/pagination_scroll_controller.dart';
import 'package:cubit_movies/shared/core/base/pagination_scroll_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final MoviesService moviesService;

  HomeCubit(this.moviesService) : super(HomeEmptyState()) {
    onInit();
  }

  late PaginationScrollController moviesSC;
  HomeEnums type = HomeEnums.main;
  bool stopPagination = false;
  int page = 1;

  final List<MoviesResponse> movies = [];

  void onInit() async {
    emit(HomeLoadingState());
    moviesSC = PaginationScrollController(initMoviesSC);
    await getStartMovies();
    emit(
      HomeLoadedState(
        movies: movies,
        moviesSC: moviesSC,
        paginationLoader: false,
      ),
    );
  }

  void initMoviesSC() {
    if (!stopPagination) {
      page += 1;
      currentFunction();
    }
  }

  void currentFunction() {
    switch (type) {
      case HomeEnums.main:
        getAllMovies();
        break;
      case HomeEnums.search:
        searchMoviesByQuery(query);
        break;
      case HomeEnums.filter:
        filterRequest!.page = page;
        applyFilter();
        break;
      default:
        log('unsupported');
        break;
    }
  }

  Future<void> getStartMovies() async {
    final List<MoviesResponse> _loadedMovies = await getMovies(
      MoviesRequest(page: page),
    );
    stopPagination = _loadedMovies.isEmpty;
    movies.addAll(_loadedMovies);
  }

  void getAllMovies([type = HomeEnums.main]) async {
    if (type != HomeEnums.main) {
      emit(HomeMoviesLoadingState());
    } else if (page == 1) {
      emit(HomeLoadingState());
    } else {
      emit(
        HomeLoadedState(
          movies: movies,
          moviesSC: moviesSC,
          paginationLoader: true,
        ),
      );
      setToCircularIndicator(moviesSC);
    }
    final List<MoviesResponse> _loadedMovies = await getMovies(
      MoviesRequest(page: page),
    );
    stopPagination = _loadedMovies.isEmpty;
    movies.addAll(_loadedMovies);
    emit(
      HomeLoadedState(
        movies: movies,
        moviesSC: moviesSC,
        paginationLoader: false,
      ),
    );
  }

  Future<List<MoviesResponse>> getMovies(MoviesRequest data) async {
    return await moviesService.getMovies(data);
  }

  Timer? _searchDebounce;
  String query = '';

  void searchMovies(String v) async {
    filterModel = null;
    if (v.isEmpty) {
      resetSearchFilter();
    } else {
      if (query != v) {
        query = v;
        type = HomeEnums.search;
        if (_searchDebounce?.isActive ?? false) {
          _searchDebounce!.cancel();
        }
        _searchDebounce = Timer(
          const Duration(seconds: 1),
          () async {
            if (query.isNotEmpty) {
              clearMovies();
              searchMoviesByQuery(query);
            }
          },
        );
      }
    }
  }

  void searchMoviesByQuery(String query) async {
    if (page == 1) {
      emit(HomeMoviesLoadingState());
    } else {
      emit(
        HomeLoadedState(
          movies: movies,
          moviesSC: moviesSC,
          paginationLoader: true,
        ),
      );
      setToCircularIndicator(moviesSC);
    }
    final List<MoviesResponse> _loadedMovies = await moviesService.getMoviesByQuery(
      MoviesQueryRequest(
        page: page,
        query: query,
      ),
    );
    stopPagination = _loadedMovies.isEmpty;
    movies.addAll(_loadedMovies);
    emit(
      HomeLoadedState(
        movies: movies,
        moviesSC: moviesSC,
        paginationLoader: false,
      ),
    );
  }

  FilterModel? filterModel;
  FilterRequest? filterRequest;

  void applyFilter() async {
    if (page == 1) {
      emit(HomeMoviesLoadingState());
      clearMovies();
      query = '';
      setFilter();
      type = HomeEnums.filter;
    } else {
      emit(
        HomeLoadedState(
          movies: movies,
          moviesSC: moviesSC,
          paginationLoader: true,
        ),
      );
    }
    final List<MoviesResponse> _loadedMovies = await moviesService.getMoviesByFilter(
      filterRequest!,
    );
    stopPagination = _loadedMovies.isEmpty;
    movies.addAll(_loadedMovies);
    emit(
      HomeLoadedState(
        movies: movies,
        moviesSC: moviesSC,
        paginationLoader: false,
      ),
    );
  }

  void setFilter() {
    int? year = int.tryParse(filterModel!.year);
    if (year != null) {
      if (year < 1920 || year > DateTime.now().year) {
        year = null;
      }
    }
    List<String> genresStrings = [];
    for (GenreResponse e in filterModel!.selectedGenres) {
      if (e.id != null) {
        genresStrings.add(e.id.toString());
      }
    }
    final String withGenres = genresStrings.toString().replaceAll('[', '').replaceAll(']', '');
    filterRequest = FilterRequest(
      year: year,
      withGenres: withGenres,
    );
  }

  void resetSearchFilter() {
    query = '';
    filterModel = null;
    type = HomeEnums.main;
    clearMovies();
    getAllMovies(HomeEnums.search);
  }

  void clearMovies() {
    page = 1;
    movies.clear();
  }
}
