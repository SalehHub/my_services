import '../../../my_services.dart';

class MyPhoneInput extends StatelessWidget {
  const MyPhoneInput({
    super.key,
    required this.selectedCountry,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
    this.onCountrySelect,
    this.value,
    this.labelText,
  });

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<Country>? onCountrySelect;
  final Country selectedCountry;
  final TextEditingController? controller;
  final String? value;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    var myServicesLabels = getMyServicesLabels(context);
    return MyTextInput(
      autofillHints: const [AutofillHints.telephoneNumberNational],
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      //
      value: value,
      digitsOnly: true,
      length: 12,
      controller: controller,
      // prefixText: selectedCountry.dialCode,
      labelText: labelText ?? myServicesLabels.mobileNumber,
      validator: defaultFieldRequiredValidator,
      textDirection: TextDirection.ltr,
      directionalityTextDirection: TextDirection.ltr,
      prefixIcon: buildSuffix(context),
      suffixIcon: buildPrefix(),
      contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
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
