import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

part 'localization.g.dart';

// https://docs.google.com/spreadsheets/d/1nhH5990kDOzW5YpskmogpU4h-VYYovZzUMu8NdOzEW4/edit?usp=sharing
@SheetLocalization('1nhH5990kDOzW5YpskmogpU4h-VYYovZzUMu8NdOzEW4', '0', 2) // <- See 1. to get DOCID and SHEETID
// the `1` is the generated version. You must increment it each time you want to regenerate
// a new version of the labels.
class MyServicesLocalizationsDelegate extends LocalizationsDelegate<MyServicesLocalizationsData> {
  const MyServicesLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => localizedLabels.containsKey(locale);

  @override
  Future<MyServicesLocalizationsData> load(Locale locale) => SynchronousFuture<MyServicesLocalizationsData>(localizedLabels[locale]!);
  @override
  bool shouldReload(MyServicesLocalizationsDelegate old) => false;
}

MyServicesLocalizationsData getLabels(BuildContext context) => context.localizations;

extension AppLocalizationsExtensions on BuildContext {
  MyServicesLocalizationsData get localizations {
    return Localizations.of<MyServicesLocalizationsData>(this, MyServicesLocalizationsData)!;
  }
}
