import '../my_services.dart';
import 'service_dialog.dart';
//
import 'service_firebase_crashlytics.dart';//firebaseCrashlytics
import 'service_firebase_messaging.dart';//firebaseMessaging
import 'service_firebase_auth.dart';//firebaseAuth
//
import 'service_locales.dart';
import 'service_theme.dart';

class Services {
  static const Services _s = Services._();
  factory Services() => _s;
  const Services._();
  //
  static void register() {
    //
    GetIt.I.registerLazySingleton<ServiceSnackBar>(() => ServiceSnackBar());
    GetIt.I.registerLazySingleton<ServiceURLLauncher>(() => ServiceURLLauncher());
    GetIt.I.registerLazySingleton<ServiceTheme>(() => ServiceTheme());
    GetIt.I.registerLazySingleton<ServiceNav>(() => ServiceNav());
    GetIt.I.registerLazySingleton<ServiceLocale>(() => ServiceLocale());
    GetIt.I.registerLazySingleton<ServiceLoader>(() => ServiceLoader());
    GetIt.I.registerLazySingleton<ServiceDialog>(() => ServiceDialog());
    GetIt.I.registerLazySingleton<ServiceDebounce>(() => ServiceDebounce());
    GetIt.I.registerLazySingleton<ServiceColor>(() => ServiceColor());
    GetIt.I.registerLazySingleton<ServiceAppDevice>(() => ServiceAppDevice());
    GetIt.I.registerLazySingleton<ServiceApi>(() => ServiceApi());
    //
    GetIt.I.registerLazySingleton<ServiceShare>(() => ServiceShare()); //sharePlus
    GetIt.I.registerLazySingleton<ServiceImagePicker>(() => ServiceImagePicker()); //imagePicker
    //
    GetIt.I.registerLazySingleton<ServiceFirebaseCrashlytics>(() => ServiceFirebaseCrashlytics()); //firebaseCrashlytics
    GetIt.I.registerLazySingleton<ServiceFirebaseMessaging>(() => ServiceFirebaseMessaging()); //firebaseMessaging
    GetIt.I.registerLazySingleton<ServiceFirebaseAuth>(() => ServiceFirebaseAuth()); //firebaseAuth
    //
    GetIt.I.registerLazySingleton<ServiceDynamicLink>(() => ServiceDynamicLink()); //appLinks
    GetIt.I.registerLazySingleton<ServiceAppBadger>(() => ServiceAppBadger()); //flutterAppBadger
    GetIt.I.registerLazySingleton<ServiceGoogleMapsCluster>(() => ServiceGoogleMapsCluster()); //googleMaps
    //
  }

  //
  ServiceSnackBar get snackBar => GetIt.I<ServiceSnackBar>();
  ServiceURLLauncher get urlLauncher => GetIt.I<ServiceURLLauncher>();
  ServiceTheme get theme => GetIt.I<ServiceTheme>();
  ServiceNav get nav => GetIt.I<ServiceNav>();
  ServiceLocale get locale => GetIt.I<ServiceLocale>();
  ServiceLoader get loader => GetIt.I<ServiceLoader>();
  ServiceDialog get dialog => GetIt.I<ServiceDialog>();
  ServiceDebounce get debounce => GetIt.I<ServiceDebounce>();
  ServiceColor get color => GetIt.I<ServiceColor>();
  ServiceAppDevice get appDevice => GetIt.I<ServiceAppDevice>();
  ServiceApi get api => GetIt.I<ServiceApi>();
  //
  ServiceShare get share => GetIt.I<ServiceShare>(); //sharePlus
  ServiceImagePicker get imagePicker => GetIt.I<ServiceImagePicker>(); //imagePicker
  //
  ServiceFirebaseCrashlytics get firebaseCrashlytics => GetIt.I<ServiceFirebaseCrashlytics>(); //firebaseCrashlytics
  ServiceFirebaseMessaging get firebaseMessaging => GetIt.I<ServiceFirebaseMessaging>(); //firebaseMessaging
  ServiceFirebaseAuth get firebaseAuth => GetIt.I<ServiceFirebaseAuth>(); //firebaseAuth
  //
  ServiceDynamicLink get dynamicLink => GetIt.I<ServiceDynamicLink>(); //appLinks
  ServiceAppBadger get appBadger => GetIt.I<ServiceAppBadger>(); //flutterAppBadger
  ServiceGoogleMapsCluster get googleMapsCluster => GetIt.I<ServiceGoogleMapsCluster>(); //googleMaps
  //
}
