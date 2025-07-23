import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../extensions/app_theme_extensions.dart';

DateTime? _lastExitAttempt;

Future<bool> showExitConfirmationToast(BuildContext context) async {
  final now = DateTime.now();
  const exitWarningDuration = Duration(seconds: 2);

  if (_lastExitAttempt == null ||
      now.difference(_lastExitAttempt!) > exitWarningDuration) {
    _lastExitAttempt = now;
    final appColor = Theme.of(context).extension<AppThemeColors>();

    Fluttertoast.showToast(
      msg: "Tap once more to exit",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: appColor!.dynamicIconColor, // You can customize this
      textColor: appColor.background,
      fontSize: 14.0,
    );

    return Future.value(false); // Do not exit the app
  }

  return Future.value(true); // Exit the app
}
