import 'package:flutter/material.dart';

import '../service_theme.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (Platform.isIOS) {
    //   return const Center(child: CupertinoActivityIndicator());
    // }
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(getTheme(context).toggleableActiveColor),
        backgroundColor: isDark(context) ? Colors.white : null,
      ),
    );
  }
}
