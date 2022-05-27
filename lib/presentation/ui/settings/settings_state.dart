import 'package:cubit_movies/domain/models/location_model.dart';

abstract class SettingsState {}

class SettingsEmptyState extends SettingsState {}

class SettingsErrorState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsPaginationState extends SettingsState {}

class SettingsLoadedState extends SettingsState {
  LocationModel? location;

  SettingsLoadedState({
    required this.location,
  });
}
