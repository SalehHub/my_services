import '../../my_services.dart';
import 'country_list.dart';

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
      // prefixText: selectedCountry.dialCode,
      labelText: labelText ?? myServicesLabels.mobileNumber,
      validator: defaultFieldRequiredValidator,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      textDirection: TextDirection.ltr,
      directionalityTextDirection: TextDirection.ltr,
      prefixIcon: buildSuffix(context),
      suffixIcon: buildPrefix(),
      contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      onChanged: onChanged,
    );
  }

  Icon buildPrefix() => const Icon(Icons.phone_android);

  Widget buildSuffix(BuildContext context) {
    var myServicesLabels = getMyServicesLabels(context);
    return GestureDetector(
      onTap: () {
        MyServices.services.dialog.show(
          title: myServicesLabels.country,
          child: CountriesListWidget(
            showDialCode: true,
            popOnSelect: true,
            onCountrySelect: onCountrySelect,
          ),
        );
      },
      child: CountryEmoji(country: selectedCountry),
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
        key: Key(selectedCountry.code),
        onTap: () => showPopup(context),
        withController: false,
        value: CountriesData.getCountryLocaleName(selectedCountry.code, MyServices.services.locale.currentLocaleLangCode(context)),
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

    MyServices.services.dialog.show(
      title: myServicesLabels.country,
      child: CountriesListWidget(
        showDialCode: false,
        popOnSelect: true,
        onCountrySelect: onCountrySelect,
      ),
    );

    // MyServices.services.dialog.show(
    //   title: myServicesLabels.country,
    //   children: [
    //     CountrySearchListWidget(
    //       countries,
    //       MyServices.services.locale.currentLocaleLangCode(context),
    //       onSelect: onCountrySelect,
    //       showDailCode: false,
    //     ),
    //   ],
    // );
  }

  Widget buildSuffix() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => showPopup(context),
        child: CountryEmoji(country: selectedCountry, showDialCode: false),
      );
    });
  }
}
