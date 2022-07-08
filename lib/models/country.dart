import '../my_services.dart';

part 'country.freezed.dart';

part 'country.g.dart';

@freezed
class Country with _$Country {
  const Country._();

  factory Country({
    required String name,
    required String code,
    required String? dialCode,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}
