import 'package:flutter/material.dart';

import '../services/exports.dart';

dynamic showMyDialog({
  required BuildContext context,
  required String title,
  TextStyle? titleStyle,
  List<Widget>? children,
  bool barrierDismissible = true,
  EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
  Color? backgroundColor,
  Color? borderColor,
  double? borderWidth,
}) {
  return showDialog<dynamic>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext c) {
        return GestureDetector(
          onTap: () => barrierDismissible ? Navigator.of(context).pop() : null,
          child: MyDialog(
            title: title,
            insetPadding: insetPadding,
            titleStyle: titleStyle,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            borderWidth: borderWidth,
            children: children,
          ),
        );
      });
}

class MyDialog extends StatelessWidget {
  const MyDialog({
    Key? key,
    this.title = '',
    this.children,
    required this.insetPadding,
    this.titleStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  final String title;
  final List<Widget>? children;
  final EdgeInsets insetPadding;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {}, // this is needed to prevents taps from dismissing the dialog
          child: SimpleDialog(
            backgroundColor: backgroundColor,
            insetPadding: insetPadding,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor ?? Colors.transparent, width: borderWidth ?? 0),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            title: Text(title, textAlign: TextAlign.center, style: titleStyle),
            titleTextStyle: getTextTheme(context).headline6,
            children: children,
          ),
        ),
      ),
    );
  }
}
