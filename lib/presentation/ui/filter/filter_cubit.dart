import 'package:cubit_movies/data/remote/filter_service.dart';
import 'package:cubit_movies/domain/models/filter_model.dart';
import 'package:cubit_movies/domain/responses/genre_response.dart';
import 'package:cubit_movies/presentation/ui/filter/filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<FilterState> {
  final FilterModel? filterModel;
  final FilterService filterService;

  FilterCubit({
    required this.filterModel,
    required this.filterService,
  }) : super(FilterEmptyState()) {
    onInit();
  }

  void onInit() async {
    emit(FilterLoadingState());
    setFilter();
    await getGenres();
    emit(
      FilterLoadedState(
        genres: genres,
        selectedGenres: selectedGenres,
      ),
    );
  }

  void setFilter() {
    if (filterModel != null) {
      yearText = filterModel!.year;
      selectedGenres = filterModel!.selectedGenres;
    }
  }

  String yearText = '';
  FilterModel? filter;

  List<GenreResponse> genres = [];
  List<GenreResponse> selectedGenres = [];

  Future<void> getGenres() async {
    genres = await filterService.getGenres();
  }

  void setGenre({
    required GenreResponse genre,
    required bool value,
  }) {
    if (value) {
      selectedGenres.add(genre);
    } else {
      selectedGenres.removeWhere((e) => e.id == genre.id);
    }
    emit(
      FilterLoadedState(
        genres: genres,
        selectedGenres: selectedGenres,
      ),
    );
  }

  bool applyFilter(String yearTC) {
    if (selectedGenres.isNotEmpty) {
      filter = FilterModel(
        year: yearTC,
        selectedGenres: selectedGenres,
      );
      return true;
    } else {
      return false;
    }
  }
}