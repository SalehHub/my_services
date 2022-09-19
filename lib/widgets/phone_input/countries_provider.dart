import '../../my_services.dart';

class CountriesProvider {
  const CountriesProvider._();
  static const CountriesProvider _s = CountriesProvider._();
  factory CountriesProvider() => _s;

  static Country? _dataToCountry(Map<String, dynamic> data) {
    if (data.isNotEmpty) {
      String? code = data['alpha_2_code'];
      // String? dialCode = data['dial_code'];

      if (code != null) {
        return Country(code: code);
      }
    }
    return null;
  }

  static Country? getByCountryCode(String code) {
    Map<String, dynamic> data = CountriesData.getByCountryCode(code);
    return _dataToCountry(data);
  }

  // static Country? getCountryByDialCode(String dialCode) {
  //   Map<String, dynamic> data = CountriesData.getCountryByDialCode(dialCode);
  //   return _dataToCountry(data);
  // }

  static List<Country> search(String term, {bool showAllOption = false}) {
    return CountriesData.search(term, showAllOption: showAllOption).map((data) => _dataToCountry(data)).whereType<Country>().toList();
  }

  static List<Country> getAll() {
    return CountriesData.getAll.map((data) => _dataToCountry(data)).whereType<Country>().toList();
  }
}
