import 'package:flutter/material.dart';

import 'my_services.dart';

void showTextSnackBar({
  String text = '',
  Color? backgroundColor,
  double elevation = 3.0,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  EdgeInsets margin = const EdgeInsets.all(10),
  int seconds = 3,
  GestureTapCallback? onTap,
}) {
  //Scaffold.of(context)
  showSnackBar(
    margin: margin,
    backgroundColor: backgroundColor ?? Colors.green.shade800,
    elevation: elevation,
    behavior: behavior,
    seconds: seconds,
    content: GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    ),
  );
}

void hideSnackBar() {
  final BuildContext? context = ServiceNav.navigatorKey.currentContext;
  if (context != null) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

void showSnackBar({
  required Widget content,
  Color? backgroundColor = Colors.black,
  double elevation = 3.0,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  EdgeInsets margin = const EdgeInsets.all(10),
  int seconds = 3,
}) {
  try {
    final BuildContext? context = ServiceNav.navigatorKey.currentContext;
    if (context != null) {
      //Scaffold.of(context)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: seconds),
          margin: margin,
          backgroundColor: backgroundColor,
          elevation: elevation,
          behavior: behavior,
          content: content,
        ),
      );
    }
  } catch (e, s) {
    logger.e(e, e, s);
  }
}
