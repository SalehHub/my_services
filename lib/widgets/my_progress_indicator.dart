import 'package:flutter/material.dart';

import '../services/exports.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({Key? key, this.margin = EdgeInsets.zero}) : super(key: key);

  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    // if (Platform.isIOS) {
    //   return const Center(child: CupertinoActivityIndicator());
    // }
    return Center(
      child: Padding(
        padding: margin,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(getTheme(context).toggleableActiveColor),
          backgroundColor: isDark(context) ? Colors.white : null,
        ),
      ),
    );
  }
}
