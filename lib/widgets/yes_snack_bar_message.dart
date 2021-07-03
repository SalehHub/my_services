import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../localization.dart';

class YesSnackBarMessage extends StatelessWidget {
  const YesSnackBarMessage({Key? key, this.text = '', this.onYes}) : super(key: key);

  final String text;
  final VoidCallback? onYes;

  @override
  Widget build(BuildContext context) {
    final labels = getLabels(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
          OutlinedButton(
            style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            onPressed: onYes,
            child: Text(labels.yes, style: GoogleFonts.tajawal()),
          )
        ],
      ),
    );
  }
}
