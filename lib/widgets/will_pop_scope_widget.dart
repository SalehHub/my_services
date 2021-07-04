import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers.dart';
import '../localization.dart';
import 'yes_snack_bar_message.dart';

class WillPopScopeWidget extends StatelessWidget {
  const WillPopScopeWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final labels = getLabels(context);

    return WillPopScope(
      onWillPop: () {
        Helpers.hideSnackBar();
        Helpers.showSnackBar(
          elevation: 2,
          seconds: 2,
          content: YesSnackBarMessage(
            text: labels.areYouSureYouWantToCloseTheApp,
            onYes: SystemNavigator.pop,
          ),
        );
        return Future<bool>.value(false);
      },
      child: child,
    );
  }
}
