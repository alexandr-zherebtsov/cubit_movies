import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

Widget buildProgressArea(BuildContext context) {
  return ColoredBox(
    color: Theme.of(context).scaffoldBackgroundColor,
    child: const SafeArea(
      child: AppProgress(),
    ),
  );
}

class AppProgress extends StatelessWidget {
  const AppProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: kIsWeb ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      ) : Platform.isIOS || Platform.isMacOS ? const CupertinoActivityIndicator() : CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      ),
    );
  }
}
