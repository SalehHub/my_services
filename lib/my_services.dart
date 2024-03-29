// ignore_for_file: depend_on_referenced_packages

export 'dart:async';
export 'dart:convert' hide Codec;
export 'dart:io';
export 'dart:isolate';
export 'dart:math';
export 'dart:typed_data';
export 'dart:ui' show ImageFilter;
//
export 'package:app_links/app_links.dart'; //appLinks
export 'package:app_settings/app_settings.dart'; //appSettings
//
export 'package:firebase_core/firebase_core.dart'; //firebaseCore
export 'package:firebase_crashlytics/firebase_crashlytics.dart'; //firebaseCrashlytics
export 'package:firebase_messaging/firebase_messaging.dart'; //firebaseMessaging
export 'package:firebase_auth/firebase_auth.dart'; //firebaseAuth
//
export 'package:flutter_app_badger/flutter_app_badger.dart'; //flutterAppBadger
export 'package:flutter_image_compress/flutter_image_compress.dart'; //imagePicker
export 'package:flutter_svg/flutter_svg.dart'; //flutterSvg
export 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart'; //googleMaps
export 'package:google_maps_flutter/google_maps_flutter.dart' hide MapType; //googleMaps
export 'package:hive/hive.dart'; //hive
export 'package:hive_flutter/hive_flutter.dart'; //hive
export 'package:image_cropper/image_cropper.dart'; //imagePicker
export 'package:image_picker/image_picker.dart'; //imagePicker
export 'package:photo_view/photo_view.dart'; //photoView
export 'package:photo_view/photo_view_gallery.dart'; //photoView

// export 'package:pin_code_fields/pin_code_fields.dart'; //pinCodeFields
export 'package:pinput/pinput.dart'; //pinCodeFields

export 'package:share_plus/share_plus.dart'; //sharePlus
export 'package:smooth_page_indicator/smooth_page_indicator.dart'; //photoView
export 'package:sqflite/sqflite.dart'; //sqflite
export 'package:map_launcher/map_launcher.dart'; //mapLauncher
export 'package:location/location.dart'; //location
//
export 'package:cached_network_image/cached_network_image.dart';
export 'package:crypto/crypto.dart';
export 'package:device_info_plus/device_info_plus.dart';
export 'package:package_info_plus/package_info_plus.dart';
export 'package:dio/dio.dart'; //dio
//
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart' hide binarySearch, mergeSort;
export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart';
export 'package:flutter/rendering.dart';
export 'package:flutter/services.dart' hide MessageHandler;
export 'package:flutter_blurhash/flutter_blurhash.dart';
export 'package:flutter_image/flutter_image.dart';
export "package:collection/collection.dart";
//
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncError, describeIdentity, shortHash;
export 'package:flutter_sheet_localization/flutter_sheet_localization.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:google_fonts/google_fonts.dart';
//
export 'package:intl/intl.dart' hide TextDirection;
export 'package:logger/logger.dart';
export 'package:mdi/mdi.dart';
export 'package:octo_image/octo_image.dart';
export 'package:get_it/get_it.dart';
export 'package:path/path.dart' hide Style, context;
export 'package:path_provider/path_provider.dart';
//
export 'package:timeago/timeago.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:uuid/uuid.dart';
//
// export 'src/databases/exports.dart';
export 'src/models/exports.dart';
export 'src/others/exports.dart';
export 'src/providers/exports.dart' show readProviderNotifier, readProviderState;
export 'src/services/service_nav.dart' show pop, push, popToHome;
export 'src/services/service_firebase_messaging.dart' show FirebaseMessagingPlace; //firebaseMessaging
export 'src/services/service_google_maps_cluster.dart' show GoogleMapsCluster; //googleMaps
export 'src/widgets/exports.dart';
export 'main.dart';
