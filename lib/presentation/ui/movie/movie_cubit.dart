import 'package:cubit_movies/data/remote/movies_service.dart';
import 'package:cubit_movies/domain/request/movie_request.dart';
import 'package:cubit_movies/domain/responses/movie_response.dart';
import 'package:cubit_movies/presentation/ui/movie/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCubit extends Cubit<MovieState> {
  final int? movieId;
  final MoviesService moviesService;

  MovieCubit({
    required this.movieId,
    required this.moviesService,
  }) : super(MovieLoadingState()) {
    getMovie();
  }

  Future<void> getMovie() async {
    if (movieId == null) {
      emit(MovieErrorState());
    } else {
      emit(MovieLoadingState());
      final MovieResponse? loadedMovie = await moviesService.getMovie(
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
