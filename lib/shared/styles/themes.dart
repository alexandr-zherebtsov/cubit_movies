import 'dart:ui';

import 'package:cubit_movies/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static ThemeData getTheme() {
    switch (window.platformBrightness) {
      case Brightness.dark:
        return dark;
      default:
        return light;
    }
  }

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.pinkAccent,
    primarySwatch: AppColors.pinkAccent,
    androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
    brightness: AppColors.brightnessLight,
    dividerColor: AppColors.lightGray,
    backgroundColor: AppColors.lightGray,
    dialogBackgroundColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.lightGray,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.black,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
      color: AppColors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 21.0,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 32.0,
      ),
      headline2: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      ),
      headline3: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
      bodyText1: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 19.0,
      ),
      caption: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      ),
    ),
  );
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.pinkAccent,
    primarySwatch: AppColors.pinkAccent,
    androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
    brightness: AppColors.brightnessDark,
    dividerColor: AppColors.darkGray,
    backgroundColor: AppColors.darkGray,
    dialogBackgroundColor: AppColors.darkGray,
    scaffoldBackgroundColor: AppColors.black,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.black,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
      toolbarHeight: 68,
      color: AppColors.black,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 21.0,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 32.0,
      ),
      headline2: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      ),
      headline3: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
      bodyText1: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w400,
        fontSize: 19.0,
      ),
      caption: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      ),
    ),
  );
}
