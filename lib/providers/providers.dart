import '../my_services.dart';
import 'general_state_provider.dart';

final _initialGeneralStateProvider = Provider<GeneralState>((ref) => throw UnimplementedError(''));
final _generalStateProvider = StateNotifierProvider<GeneralStateNotifier, GeneralState>((ref) {
  return GeneralStateNotifier(ref.watch(_initialGeneralStateProvider), ref);
});

readProviderNotifier<T>(ProviderBase<T> provider) {
  if (provider is StateNotifierProvider<StateNotifier<T>, T>) {
    return MyServices.providers.ref.read(provider.notifier);
  } else if (provider is StateProvider<T>) {
    return MyServices.providers.ref.read(provider.notifier);
  } else if (provider is AutoDisposeStateProvider<T>) {
    return MyServices.providers.ref.read(provider.notifier);
  }

  //TODO:  not correct
  return (provider as dynamic).notifier;
}

T readProviderState<T>(ProviderBase<T> provider) {
  // if (provider is StateNotifierProvider<StateNotifier<T>, T>) {
  //   return MyServices.providers.ref.read<T>(provider);
  // } else if (provider is StateProvider<T>) {
  //   return MyServices.providers.ref.read<T>(provider);
  // } else if (provider is AutoDisposeStateProvider<T>) {
  //   return MyServices.providers.ref.read<T>(provider);
  // }

  return MyServices.providers.ref.read<T>(provider);
}

class Providers {
  //
  late WidgetRef _ref;
  WidgetRef get ref => _ref;
  WidgetRef setRef(WidgetRef ref) => _ref = ref;

  //
  GeneralState get _generalState => readProviderState(_generalStateProvider);
  GeneralStateNotifier get _generalStateNotifier => readProviderNotifier(_generalStateProvider);

  //
  Future<void> setAccessToken(String? value) => _generalStateNotifier.setAccessToken(value);
  Future<void> setThemeMode(BuildContext context, ThemeMode value) => _generalStateNotifier.setThemeMode(context, value);
  Future<void> toggleThemeMode(BuildContext context) => _generalStateNotifier.toggleThemeMode(context);
  Future<void> setLocale(Locale value) {
    if (MyServices.services.locale.isSupportedLocale(value)) {
      return _generalStateNotifier.setLocale(value);
    } else {
      logger.e("Unsupported locale");
      return Future.value(null);
    }
  }

  //
  Map<String, dynamic> asMap() => _generalStateNotifier.asMap;

  //
  bool watchIsFirstAppRun(dynamic ref) => ref.watch(_generalStateProvider.select((s) => s.isFirstAppRun));
  String? watchAccessToken(dynamic ref) => ref.watch(_generalStateProvider.select((s) => s.accessToken));
  bool watchIsFirstAppBuildRun(dynamic ref) => ref.watch(_generalStateProvider.select((s) => s.isFirstAppBuildRun));
  ThemeMode? watchThemeMode(dynamic ref) => ref.watch(_generalStateProvider.select((s) => s.themeMode));
  String? watchNotificationToken(dynamic ref) => ref.watch(_generalStateProvider.select((s) => s.notificationToken));
  String? watchAppBuild(dynamic ref) => ref.watch(_generalStateProvider.select((s) => s.appDeviceData?.appBuild));
  Locale? watchLocale(dynamic ref) {
    if (MyServices.appConfig.nativeLocaleChange) {
      return null;
    }
    return ref.watch(_generalStateProvider.select((s) => s.locale));
  }

  //
  String? get readAccessToken => _generalState.accessToken;
  String? get readNotificationToken => _generalState.notificationToken;
  ThemeMode? get readThemeMode => _generalState.themeMode;
  bool get readIsFirstAppBuildRun => _generalState.isFirstAppBuildRun;
  bool get readIsFirstAppRun => _generalState.isFirstAppRun;
  Locale? get readLocale => _generalState.locale;
  String? get readAppBuild => _generalState.appDeviceData?.appBuild;

  //
  void onLocaleChange(WidgetRef ref, Function(Locale? previous, Locale? next) listener) {
    ref.listen<Locale?>(_generalStateProvider.select((s) => s.locale), listener);
  }

  Override overrideGeneralStateWithValue(GeneralState generalState) {
    return _initialGeneralStateProvider.overrideWithValue(generalState);
  }
}
