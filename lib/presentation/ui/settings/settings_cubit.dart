import 'dart:convert';

import 'package:cubit_movies/data/local/preferences.dart';
import 'package:cubit_movies/data/remote/location_service.dart';
import 'package:cubit_movies/domain/models/location_model.dart';
import 'package:cubit_movies/presentation/ui/settings/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Preferences pref;
  final LocationService locationService;

  SettingsCubit({
    required this.pref,
    required this.locationService,
  }) : super(SettingsLoadingState()) {
    getData();
  }

  void getData() async {
    getLocation();
  }

  Future<void> getLocation() async {
    emit(SettingsLoadingState());
    String? _prefLoc = await pref.getCurrentLocation();
    if (_prefLoc == null) {
      await locationService.determineLocation();
      _prefLoc = await pref.getCurrentLocation();
    }
    LocationModel? _location;
    if (_prefLoc != null) {
      Map<String, dynamic> _prefLocMap = jsonDecode(_prefLoc);
      _location = LocationModel.fromJson(_prefLocMap);
    }
    emit(
      SettingsLoadedState(
        location: _location,
      ),
    );
  }
}
