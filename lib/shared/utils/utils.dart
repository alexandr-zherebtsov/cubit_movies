import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cubit_movies/shared/constants/app_values.dart';
import 'package:cubit_movies/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void errorToast({
  required String? code,
  required String? message,
}) {
  try {
    Fluttertoast.showToast(
      msg: 'Error Code: $code\nError Message: $message',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColors.red.withOpacity(0.8),
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  } catch (e) {
    log(e.toString());
  }
}

bool isMobile() {
  if (kIsWeb) {
    return false;
  } else if (Platform.isWindows) {
    return false;
  } else {
    return true;
  }
}

IconData getBackIcon() {
  if (kIsWeb) {
    return Icons.arrow_back;
  } else if (Platform.isIOS || Platform.isMacOS) {
    return Icons.arrow_back_ios;
  } else {
    return Icons.arrow_back;
  }
}

double doubleParser(dynamic data) {
  final double? doubleResult = double.tryParse(data.toString());
  if (doubleResult != null) {
    return doubleResult;
  } else {
    return 0.0;
  }
}

String getClearName(String? firstName, String? lastName, {bool comma = false}) {
  return (firstName ?? '') + (firstName == null ? '' : firstName.isEmpty ? ''
      : comma ? lastName == null ? '' : lastName.isEmpty ? '' : ', ' : ' ')
      + (lastName ?? '');
}

String getLangCode() {
  try {
    switch (window.locale.languageCode) {
      case AppValues.langCodeUk:
        return AppValues.langCodeUk;
      case AppValues.langCodeEn:
        return AppValues.langCodeEn;
      default:
        return AppValues.langCodeBasic;
    }
  } catch (e) {
    return AppValues.langCodeBasic;
  }
}

Future<void> futureDelayed({int milliseconds = 1000}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
