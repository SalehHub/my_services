import '../my_services.dart';
import 'service_api.dart';
import 'service_app_badger.dart'; //flutterAppBadger
import 'service_app_device.dart';
import 'service_color.dart';
import 'service_debounce.dart';
import 'service_dialog.dart';
//
import 'service_dynamic_link.dart'; //appLinks
//
import 'service_firebase_crashlytics.dart'; //firebaseCrashlytics
import 'service_firebase_messaging.dart'; //firebaseMessaging
import 'service_firebase_auth.dart'; //firebaseAuth
//
import 'service_google_maps_cluster.dart'; //googleMaps
import 'service_image_picker.dart'; //imagePicker
import 'service_loader.dart';
import 'service_locales.dart';
import 'service_nav.dart';
import 'service_share.dart'; //sharePlus
import 'service_snack_bar.dart';
import 'service_theme.dart';
import 'service_url_launcher.dart';

class Services {
  //
  static const Services _s = Services._();
  factory Services() => _s;
  const Services._();
  //
  static void register() {
    //
    GetIt.I.registerLazySingleton<ServiceSnackBar>(() => const ServiceSnackBar());
    GetIt.I.registerLazySingleton<ServiceURLLauncher>(() => const ServiceURLLauncher());
    GetIt.I.registerLazySingleton<ServiceTheme>(() => const ServiceTheme());
    GetIt.I.registerLazySingleton<ServiceNav>(() => const ServiceNav());
    GetIt.I.registerLazySingleton<ServiceLocale>(() => const ServiceLocale());
    GetIt.I.registerLazySingleton<ServiceLoader>(() => const ServiceLoader());
    GetIt.I.registerLazySingleton<ServiceDialog>(() => const ServiceDialog());
    GetIt.I.registerLazySingleton<ServiceDebounce>(() => const ServiceDebounce());
    GetIt.I.registerLazySingleton<ServiceColor>(() => const ServiceColor());
    GetIt.I.registerLazySingleton<ServiceAppDevice>(() => const ServiceAppDevice());
    //not Singleton
    GetIt.I.registerFactory<ServiceApi>(() => const ServiceApi());
    //
    GetIt.I.registerLazySingleton<ServiceShare>(() => const ServiceShare()); //sharePlus
    GetIt.I.registerLazySingleton<ServiceImagePicker>(() => const ServiceImagePicker()); //imagePicker
    //
    GetIt.I.registerLazySingleton<ServiceFirebaseCrashlytics>(() => const ServiceFirebaseCrashlytics()); //firebaseCrashlytics
    GetIt.I.registerLazySingleton<ServiceFirebaseMessaging>(() => const ServiceFirebaseMessaging()); //firebaseMessaging
    GetIt.I.registerLazySingleton<ServiceFirebaseAuth>(() => const ServiceFirebaseAuth()); //firebaseAuth
    //
    GetIt.I.registerLazySingleton<ServiceDynamicLink>(() => const ServiceDynamicLink()); //appLinks
    GetIt.I.registerLazySingleton<ServiceAppBadger>(() => const ServiceAppBadger()); //flutterAppBadger
    GetIt.I.registerLazySingleton<ServiceGoogleMapsCluster>(() => const ServiceGoogleMapsCluster()); //googleMaps
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
