import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../databases/key_value_database.dart';
import '../helpers.dart';
import '../models/app_device_data.dart';
import '../models/general_state.dart';
import '../services/exports.dart';

//-----------------------//
ThemeMode watchThemeMode(WidgetRef ref) => ref.watch(generalStateProvider.select((s) => s.themeMode));
ThemeMode readThemeMode(WidgetRef ref) => ref.read(generalStateProvider).themeMode;
bool readIsFirstAppRun(WidgetRef ref) => ref.read(generalStateProvider).isFirstAppRun;
Locale? watchLocale(WidgetRef ref) => ref.watch(generalStateProvider.select((s) => s.locale));
String? watchAppBuild(WidgetRef ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData?.appBuild));
//-----------------------//

GeneralState readGeneralState(WidgetRef ref) => ref.read(generalStateProvider);
GeneralStateNotifier readGeneralStateNotifier(WidgetRef ref) => ref.read(generalStateProvider.notifier);
GeneralState watchGeneralState(WidgetRef ref) => ref.watch(generalStateProvider);

final generalStateProvider = StateNotifierProvider<GeneralStateNotifier, GeneralState>((ref) => GeneralStateNotifier(GeneralState(), ref));

class GeneralStateNotifier extends StateNotifier<GeneralState> {
  GeneralStateNotifier(GeneralState state, this.ref) : super(state);
  final ProviderRefBase ref;

  ///app
  void setThemeMode(BuildContext context, ThemeMode value) {
    state = state.copyWith(themeMode: value);
    ServiceTheme.setSystemUiOverlayStyle(value, context);
    GeneralKeyValueDatabase.setThemeMode(value);
  }

  void toggleThemeMode(BuildContext context) {
    if (isDark(context)) {
      setThemeMode(context, ThemeMode.light);
    } else {
      setThemeMode(context, ThemeMode.dark);
    }
  }

  void setLocale(Locale value) {
    state = state.copyWith(locale: value);
    GeneralKeyValueDatabase.setLocale(value);
  }
}

Future<GeneralState> getInitGeneralState(Locale defaultLocale, List<Locale> supportedLocales) async {
  logger.wtf('getInitGeneralState initialized');

  String? notificationToken;
  String? accessToken;
  Locale locale = defaultLocale;
  ThemeMode themeMode = ThemeMode.system;
  bool isFirstAppRun = false;
  bool isFirstAppBuildRun = false;
  late AppDeviceData appDeviceData;

  await Future.wait<dynamic>(
    <Future<dynamic>>[
      //-----------------------------------------------------------------//
      Helpers.getApplicationDocumentsPath().then<dynamic>((String? applicationDocumentsDirectoryPath) async {
        //
        appDeviceData = await Helpers.getAppAndDeviceData();
        //
        isFirstAppRun = await GeneralKeyValueDatabase.getIsFirstAppRun();
        isFirstAppBuildRun = await GeneralKeyValueDatabase.getIsFirstAppBuildRun(appDeviceData.appBuild);
        //
        accessToken = await GeneralKeyValueDatabase.getAccessToken();
        //
        locale = await GeneralKeyValueDatabase.getLocale(defaultLocale, supportedLocales);
        themeMode = await GeneralKeyValueDatabase.getThemeMode();
        //
      }),
      //-----------------------------------------------------------------//

      ServiceFirebaseMessaging.getToken().then<String?>((String? value) => notificationToken = value),

      //-----------------------------------------------------------------//
    ],
  );

  final GeneralState appState = GeneralState(
    accessToken: accessToken,
    notificationToken: notificationToken,
    appDeviceData: appDeviceData,
    //
    locale: locale,
    themeMode: themeMode,
    //
    isFirstAppRun: isFirstAppRun,
    isFirstAppBuildRun: isFirstAppBuildRun,

    //
  );

  logger.i(appState.appStateAsMap);

  return appState;
}
