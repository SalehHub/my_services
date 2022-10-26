import 'my_services.dart';
import 'services/services.dart';

//an alias to MyServices class
typedef MyS = MyServices;

class MyServices {
  //
  const MyServices._();
  static const MyServices _s = MyServices._();
  factory MyServices() => _s;

  static void register() {
    //register MyStorage
    GetIt.I.registerLazySingleton<MyStorage>(() {
      return MyStorageSQLite(); //sqflite
      // ignore: dead_code
      return MyStorageHive(); //hive
    });
    //
    GetIt.I.registerLazySingleton<Helpers>(() => Helpers());
    GetIt.I.registerLazySingleton<Services>(() => Services());
    GetIt.I.registerLazySingleton<Providers>(() => Providers());

    Services.register();
  }

  //
  static MyStorage get storage => GetIt.I<MyStorage>();
  static Helpers get helpers => GetIt.I<Helpers>();
  static Providers get providers => GetIt.I<Providers>();
  static Services get services => GetIt.I<Services>();

  // App Config
  static AppConfig appConfig = const AppConfig();

  // App Events
  static AppEvents appEvents = const AppEvents();

  //
  static BuildContext get context => services.nav.context;
  static WidgetRef get ref => providers.ref;
}
