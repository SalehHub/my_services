import '../../my_services.dart';

class MyCountryInput extends StatelessWidget {
  const MyCountryInput({
    super.key,
    required this.selectedCountry,
    this.onCountrySelect,
    this.enabled = true,
    this.labelText,
  });

  final ValueChanged<Country>? onCountrySelect;
  final Country selectedCountry;
  final String? labelText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    var myServicesLabels = getMyServicesLabels(context);
    return Builder(builder: (context) {
      return MyTextInput(
        enabled: enabled,
        key: Key(selectedCountry.code),
        onTap: () => showPopup(context),
        withController: false,
        digitsOnly: false,
        value: selectedCountry.localeName(),
        labelText: labelText ?? myServicesLabels.country,
        validator: defaultFieldRequiredValidator,
        prefixIcon: buildSuffix(),
        suffixIcon: buildPrefix(),
        contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      );
    });
  }

  Icon buildPrefix() => const Icon(Icons.flag);

  Widget buildSuffix() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => showPopup(context),
        child: CountryEmoji(country: selectedCountry, showDialCode: false),
      );
    });
  }

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
  }
}
