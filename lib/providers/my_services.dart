import '../my_services.dart';
import 'general_state_provider.dart';

class MyServices {
  const MyServices._();
  static const MyServices _s = MyServices._();
  factory MyServices() => _s;

  static String? readAccessToken(dynamic ref) => _readGeneralState(ref).accessToken;
  static String? watchAccessToken(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.accessToken));

  static Future<void> setAccessToken(dynamic ref, String? value) => _readGeneralStateNotifier(ref).setAccessToken(value);

  static Map<String, dynamic> asMap(Ref ref) => _readGeneralStateNotifier(ref).asMap;

  static GeneralStateNotifier _readGeneralStateNotifier(dynamic ref) => ref.read(generalStateProvider.notifier);
  static GeneralState _readGeneralState(dynamic ref) => ref.read(generalStateProvider);

  //
  static MyStorage storage = MyStorageSQLite();

  static final Helpers helpers = Helpers();
  static final ServiceSnackBar snackBar = ServiceSnackBar();
}
