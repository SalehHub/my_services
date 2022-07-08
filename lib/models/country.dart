import '../my_services.dart';

part 'country.freezed.dart';

part 'country.g.dart';

@freezed
class Country with _$Country {
  const Country._();

  factory Country({
    required String code,
    // required String? dialCode,
  }) = _Country;

  String localeName([String? locale]) {
    Map<String, dynamic> country = CountriesData.getByCountryCode(code);
    if (country.isNotEmpty) {
      locale = locale ?? MyServices.services.locale.currentLocaleLangCode(MyServices.context);
      String? localeName = country['nameTranslations'][locale] ?? country['en_short_name'];
      return localeName ?? "";
    }
    return "";
  }

  String? get dialCode {
    Map<String, dynamic> country = CountriesData.getByCountryCode(code);
    if (country.isNotEmpty) {
      return country['dial_code'];
    }
    return null;
  }

  String get emoji {
    const base = 127397;
    return code.codeUnits.map((e) => String.fromCharCode(base + e)).toList().reduce((value, element) => value + element).toString();
  }

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}
