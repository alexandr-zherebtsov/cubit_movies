import 'package:cubit_movies/data/local/preferences.dart';
import 'package:cubit_movies/data/remote/filter_service.dart';
import 'package:cubit_movies/data/remote/location_service.dart';
import 'package:cubit_movies/data/remote/movies_service.dart';
import 'package:cubit_movies/shared/core/network/dio_manager.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Preferences());
  locator.registerLazySingleton(() => DioManager());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => MoviesService());
  locator.registerLazySingleton(() => FilterService());
}
