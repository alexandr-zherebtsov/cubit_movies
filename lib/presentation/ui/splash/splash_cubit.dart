import 'package:cubit_movies/presentation/ui/splash/splash_state.dart';
import 'package:cubit_movies/shared/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final void Function() goHome;

  SplashCubit({
    required this.goHome,
  }) : super(SplashLoadingState()) {
    determineLocation();
  }

  Future<void> determineLocation() async {
    await futureDelayed();
    goHome();
  }
}
