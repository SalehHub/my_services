import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../snack_bar.dart';
import 'yes_snack_bar_message.dart';

class WillPopScopeWidget extends StatelessWidget {
  const WillPopScopeWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        hideSnackBar();
        showSnackBar(
          elevation: 2,
          seconds: 2,
          content: const YesSnackBarMessage(
            text: 'هل تريد الخروج من التطبيق؟',
            onYes: SystemNavigator.pop,
          ),
        );
        return Future<bool>.value(false);
      },
      child: child,
    );
  }
}
