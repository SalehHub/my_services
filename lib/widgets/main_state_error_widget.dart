import 'package:flutter/material.dart';

import '../localization.dart';

class FutureErrorWidget extends StatelessWidget {
  const FutureErrorWidget({Key? key, this.err}) : super(key: key);

  final Object? err;

  @override
  Widget build(BuildContext context) {
    final labels = getLabels(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            labels.anErrorOccurredPleaseTakeAScreenshotAndContactUs,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          if (err != null) Text(err.toString(), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          //  const ContactUsWidget()
        ],
      ),
    );
  }
}
