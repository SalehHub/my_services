import '../../my_services.dart';
import 'countries_search_list_widget.dart';
import 'item.dart';

class MyPhoneInput extends StatelessWidget {
  const MyPhoneInput({
    super.key,
    required this.selectedCountry,
    this.onChanged,
    this.controller,
    this.onCountrySelect,
    this.value,
    this.labelText,
  });

  final ValueChanged<String>? onChanged;
  final ValueChanged<Country>? onCountrySelect;
  final Country selectedCountry;
  final TextEditingController? controller;
  final String? value;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    var myServicesLabels = getMyServicesLabels(context);
    return MyTextInput(
      value: value,
      digitsOnly: true,
      length: 12,
      controller: controller,
      prefixText: selectedCountry.dialCode,
      labelText: labelText ?? myServicesLabels.mobileNumber,
      validator: defaultFieldRequiredValidator,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
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
            CountrySearchListWidget(
              countries,
              MyServices.services.locale.currentLocaleLangCode(context),
              onSelect: onCountrySelect,
            ),
          ],
        );
      },
      child: Item(country: selectedCountry, useEmoji: true),
    );
  }
}

class MyCountryInput extends StatelessWidget {
  const MyCountryInput({
    super.key,
    required this.selectedCountry,
    this.onCountrySelect,
    this.labelText,
  });

  final ValueChanged<Country>? onCountrySelect;
  final Country selectedCountry;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    var myServicesLabels = getMyServicesLabels(context);
    return Builder(builder: (context) {
      return MyTextInput(
        key: selectedCountry.alpha2Code != null ? Key(selectedCountry.alpha2Code!) : null,
        onTap: () => showPopup(context),
        withController: false,
        value: selectedCountry.localeName(),
        digitsOnly: true,
        length: 12,
        controller: null,
        labelText: labelText ?? myServicesLabels.country,
        validator: defaultFieldRequiredValidator,
        textInputAction: TextInputAction.done,
        prefixIcon: buildSuffix(),
        suffixIcon: buildPrefix(),
        contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      );
    });
  }

  Icon buildPrefix() => const Icon(Icons.flag);

  void showPopup(BuildContext context) {
    var myServicesLabels = getMyServicesLabels(context);
    List<Country> countries = CountryProvider.getCountriesData(countries: []);
    MyServices.services.dialog.show(
      title: myServicesLabels.country,
      children: [
        CountrySearchListWidget(
          countries,
          MyServices.services.locale.currentLocaleLangCode(context),
          onSelect: onCountrySelect,
          showDailCode: false,
        ),
      ],
    );
  }

  Widget buildSuffix() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => showPopup(context),
        child: Item(country: selectedCountry, useEmoji: true),
      );
    });
  }
}
