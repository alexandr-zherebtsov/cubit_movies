import 'package:cubit_movies/data/local/preferences.dart';
import 'package:cubit_movies/presentation/di/locator.dart';
import 'package:cubit_movies/presentation/ui/settings/settings_cubit.dart';
import 'package:cubit_movies/presentation/ui/settings/settings_state.dart';
import 'package:cubit_movies/shared/widgets/app_progress.dart';
import 'package:cubit_movies/shared/constants/strings_keys.dart';
import 'package:cubit_movies/shared/styles/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsCubit _settingsCubit;

  final Preferences _pref = locator<Preferences>();

  @override
  void initState() {
    _settingsCubit = SettingsCubit(
      pref: _pref,
    );
    super.initState();
  }

  @override
  void dispose() {
    _settingsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      bloc: _settingsCubit,
      builder: (BuildContext context, SettingsState state) {
        if (state is SettingsLoadingState) {
          return buildProgressArea(context);
        } else if (state is SettingsErrorState) {
          return const AppErrorWidget(
            showBack: true,
          );
        } else if (state is SettingsLoadedState) {
          return _buildSettings(
            context: context,
            state: state,
          );
        } else {
          return const Offstage();
        }
      },
    );
  }

  Widget _buildSettings({
    required BuildContext context,
    required SettingsLoadedState state,
  }) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(StringsKeys.settings.tr()),
        bottom: appBarDivider(),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1200,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
