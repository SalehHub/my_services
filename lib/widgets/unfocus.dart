import 'package:flutter/material.dart';

import '../helpers.dart';
import '../snack_bar.dart';

/// A widget that unfocus everything when tapped.
/// This implements the "Unfocus when tapping in empty space" behavior for the
/// entire application.
class Unfocus extends StatelessWidget {
  const Unfocus({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        hideKeyboard();
        hideSnackBar();
      },
      child: child,
    );
  }
}
