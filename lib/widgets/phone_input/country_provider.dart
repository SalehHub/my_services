// import 'country_list.dart';
// import 'country_model.dart';

// /// [CountryProvider] provides helper classes that involves manipulations.
// /// of Countries from [Countries.countryList]
// class CountryProvider {
//   /// Get data of Countries.
//   ///
//   /// Returns List of [Country].
//   ///
//   ///  * If [countries] is `null` or empty it returns a list of all [Countries.countryList].
//   ///  * If [countries] is not empty it returns a filtered list containing
//   ///    counties as specified.
//   static Country getCountryByDailCode(int code) {
//     return getCountriesData().firstWhere((e) => int.tryParse(e.dialCode ?? "966") == code);
//   }

//   static Country getCountryByAlpha2Code(String code) {
//     return getCountriesData().firstWhere((e) => e.alpha2Code == code);
//   }

//   static List<Country>? allCountries;

//   static List<Country> getCountriesData({List<String>? countries}) {
//     List jsonList = Countries.countryList;

//     if (countries == null || countries.isEmpty) {
//       allCountries ??= jsonList.map((country) => Country.fromJson(country)).toList();
//       return allCountries!;
//     }

//     if (allCountries != null) {
//       return allCountries!.where((country) {
//         return countries.contains(country.alpha2Code);
//       }).toList();
//     }

//     return allCountries!;
//   }
// }
