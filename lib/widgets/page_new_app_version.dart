import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../icons.dart';
import '../localization.dart';
import '../services/service_url_launcher.dart';
import 'main_state.dart';

class PageNewAppVersion extends ConsumerStatefulWidget {
  const PageNewAppVersion({Key? key, required this.iosAppStoreUrl, required this.androidPlayStoreUrl}) : super(key: key);
  final String iosAppStoreUrl;
  final String androidPlayStoreUrl;

  @override
  _PageNewAppVersionState createState() => _PageNewAppVersionState();
}

class _PageNewAppVersionState extends MainStateTemplate<PageNewAppVersion> {
  MyServicesLocalizationsData get labels => getMyServicesLabels(context);

  @override
  bool get hideTopAdBanner => true;

  @override
  bool get hideBottomAdBanner => true;

  @override
  String get title => labels.newVersion;

  @override
  List<Widget> get bodyChildren => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                const Icon(iconCellphoneArrowDown, size: 80, color: Colors.green),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    labels.newAppVersionIsAvailable,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.green),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Text(
                    labels.toEnjoyLatestFeaturesPleaseUpdate,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.green[800],
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () => ServiceURLLauncher.openAppOnStore(widget.iosAppStoreUrl, widget.androidPlayStoreUrl),
                    child: Text(
                      labels.updateNow,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        )
      ];
}
