import 'package:my_services/my_services.dart';

import 'countries_search_list_widget.dart';
import 'country_model.dart';
import 'country_provider.dart';
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MyTextInput(
        digitsOnly: true,
        length: 12,
        controller: controller,
        prefixText: selectedCountry.dialCode,
        labelText: myServicesLabels.mobileNumber,
        validator: defaultFieldRequiredValidator,
        textInputAction: TextInputAction.done,
        textDirection: TextDirection.ltr,

        // prefixIcon: buildPrefix(),
        // suffixIcon: buildSuffix(context ),
        prefixIcon: buildSuffix(context),
        suffixIcon: buildPrefix(),

        // prefixIcon: ServiceLocale.isAr(context) ? buildPrefix() : buildSuffix(context),
        // suffixIcon: ServiceLocale.isAr(context) ? buildSuffix(context) : buildPrefix(),

        contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        // suffixIcon: buildSuffix(context),
        // suffixIcon: ServiceLocale.isAr(context) ? buildSuffix(context) : buildPrefix(),
        onChanged: onChanged,
      ),
    );
  }

  Icon buildPrefix() => const Icon(Icons.phone_android);

  Widget buildSuffix(BuildContext context) {
    var myServicesLabels = getMyServicesLabels(context);
    List<Country> countries = CountryProvider.getCountriesData(countries: []);

    return GestureDetector(
      onTap: () {
        ServiceDialog.show(
          title: myServicesLabels.countryDialCode,
          children: [
            CountrySearchListWidget(countries, ServiceLocale.currentLocaleLangCode(context), onSelect: onCountrySelect),
          ],
        );
      },
      child: Item(country: selectedCountry, useEmoji: true),
    );
  }
}
