import '../../my_services.dart';
import 'countries_search_list_widget.dart';
import 'item.dart';

class MyPhoneInput extends StatelessWidget {
  const MyPhoneInput({Key? key, this.onChanged, this.controller, this.onCountrySelect, required this.selectedCountry}) : super(key: key);
  final ValueChanged<String>? onChanged;
  final ValueChanged<Country>? onCountrySelect;
  final Country selectedCountry;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    var myServicesLabels = getMyServicesLabels(context);
    return MyTextInput(
      digitsOnly: true,
      length: 12,
      controller: controller,
      prefixText: selectedCountry.dialCode,
      labelText: myServicesLabels.mobileNumber,
      validator: defaultFieldRequiredValidator,
      textInputAction: TextInputAction.done,
      textDirection: TextDirection.ltr,
      directionalityTextDirection: TextDirection.ltr,

      // prefixIcon: buildPrefix(),
      // suffixIcon: buildSuffix(context ),
      prefixIcon: buildSuffix(context),
      suffixIcon: buildPrefix(),

      // prefixIcon: MyServices.services.locale.isAr(context) ? buildPrefix() : buildSuffix(context),
      // suffixIcon: MyServices.services.locale.isAr(context) ? buildSuffix(context) : buildPrefix(),

      contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      // suffixIcon: buildSuffix(context),
      // suffixIcon: MyServices.services.locale.isAr(context) ? buildSuffix(context) : buildPrefix(),
      onChanged: onChanged,
    );
  }

  Icon buildPrefix() => const Icon(Icons.phone_android);

  Widget buildSuffix(BuildContext context) {
    var myServicesLabels = getMyServicesLabels(context);
    List<Country> countries = CountryProvider.getCountriesData(countries: []);

    return GestureDetector(
      onTap: () {
        MyServices.services.dialog.show(
          title: myServicesLabels.countryDialCode,
          children: [
            CountrySearchListWidget(countries, MyServices.services.locale.currentLocaleLangCode(context), onSelect: onCountrySelect),
          ],
        );
      },
      child: Item(country: selectedCountry, useEmoji: true),
    );
  }
}
