import 'package:cubit_movies/data/local/preferences.dart';
import 'package:cubit_movies/presentation/di/locator.dart';
import 'package:cubit_movies/presentation/router/router.dart';
import 'package:cubit_movies/presentation/router/routes.dart';
import 'package:cubit_movies/shared/constants/app_values.dart';
import 'package:cubit_movies/shared/styles/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  await Hive.initFlutter();
  await locator<Preferences>().openBox();
  if (kIsWeb) {
    setPathUrlStrategy();
    SystemNavigator.routeInformationUpdated(
      location: AppRoutes.splash,
    );
  }
  runApp(
    EasyLocalization(
      supportedLocales: AppValues.supportedLocales,
      path: AppValues.localesPath,
      fallbackLocale: AppValues.localeEN,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppValues.appName,
      theme: AppThemes.getTheme(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
    );
  }
}
