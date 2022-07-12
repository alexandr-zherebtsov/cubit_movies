import 'package:cubit_movies/data/remote/repositories/movies_repository.dart';
import 'package:cubit_movies/domain/request/movie_request.dart';
import 'package:cubit_movies/domain/responses/movie_response.dart';
import 'package:cubit_movies/presentation/ui/movie/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCubit extends Cubit<MovieState> {
  final MoviesRepository _moviesRepository;

  MovieCubit(
    this._moviesRepository,
  ) : super(MovieLoadingState());

  Future<void> getMovie(final int? movieId) async {
    if (movieId == null) {
      emit(MovieErrorState());
    } else {
      emit(MovieLoadingState());
      final MovieResponse? loadedMovie = await _moviesRepository.getMovie(
        MovieRequest(movieId: movieId),
      );
      if (loadedMovie == null) {
        emit(MovieErrorState());
      } else {
        emit(
          MovieLoadedState(
            movie: loadedMovie,
          ),
        );
      }
    }
  }
}
