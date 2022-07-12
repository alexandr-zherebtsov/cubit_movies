import 'package:cubit_movies/data/local/preferences.dart';
import 'package:cubit_movies/presentation/ui/settings/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Preferences _pref;

  SettingsCubit(
    this._pref,
  ) : super(SettingsLoadingState()) {
    init();
  }

  void init() {
    emit(SettingsLoadedState());
  }
}
