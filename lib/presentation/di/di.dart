import 'package:cubit_movies/data/local/preferences.dart';
import 'package:cubit_movies/data/remote/repositories/filter_repository.dart';
import 'package:cubit_movies/data/remote/repositories/movies_repository.dart';
import 'package:cubit_movies/domain/repositories/filter_repository_impl.dart';
import 'package:cubit_movies/domain/repositories/movies_repository_impl.dart';
import 'package:cubit_movies/presentation/ui/filter/filter_cubit.dart';
import 'package:cubit_movies/presentation/ui/home/home_cubit.dart';
import 'package:cubit_movies/presentation/ui/movie/movie_cubit.dart';
import 'package:cubit_movies/presentation/ui/settings/settings_cubit.dart';
import 'package:cubit_movies/shared/core/network/dio_manager.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Preferences>(() => Preferences());
  getIt.registerLazySingleton<DioManager>(() => DioManager());
  _setupRepositories();
  _setupCubits();
}

void _setupRepositories() {
  getIt.registerSingleton<MoviesRepository>(MoviesRepositoryImpl(getIt.get()));
  getIt.registerSingleton<FilterRepository>(FilterRepositoryImpl(getIt.get()));
}

void _setupCubits() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt.get()));
  getIt.registerFactory<MovieCubit>(() => MovieCubit(getIt.get()));
  getIt.registerFactory<FilterCubit>(() => FilterCubit(getIt.get()));
  getIt.registerFactory<SettingsCubit>(() => SettingsCubit(getIt.get()));
}
