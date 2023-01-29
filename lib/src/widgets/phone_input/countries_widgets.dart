import '../../../my_services.dart';
import '../../services/service_nav.dart';

class CountriesListWidget extends StatefulWidget {
  const CountriesListWidget({
    super.key,
    this.showDialCode = true,
    this.popOnSelect = true,
    this.showAllOption = false,
    this.onCountrySelect,
    this.topCountries,
  });
  final bool showDialCode;
  final bool showAllOption;
  final ValueChanged<Country>? onCountrySelect;
  final List<Country>? topCountries;
  final bool popOnSelect;

  @override
  State<CountriesListWidget> createState() => _CountriesListWidgetState();
}

class _CountriesListWidgetState extends State<CountriesListWidget> {
  String searchTerm = '';

  List<Country> get topCountries {
    if (searchTerm.trim() != "") {
      return [];
    } else if (widget.topCountries != null) {
      return widget.topCountries!;
    }

    return [
      CountriesProvider.getByCountryCode("SA"),
      CountriesProvider.getByCountryCode("AE"),
      CountriesProvider.getByCountryCode("OM"),
      CountriesProvider.getByCountryCode("KW"),
      CountriesProvider.getByCountryCode("BH"),
      CountriesProvider.getByCountryCode("QA"),
      //
      CountriesProvider.getByCountryCode("YE"),
      CountriesProvider.getByCountryCode("EG"),
      CountriesProvider.getByCountryCode("JO"),
      CountriesProvider.getByCountryCode("IQ"),
      //
    ].whereType<Country>().toList();
  }

  List<Country> get countries => [
        if (widget.showAllOption && searchTerm.trim().isEmpty) ...[const Country(code: 'all')],
        ...topCountries,
        ...CountriesProvider.search(searchTerm, showAllOption: false),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          MyTextInput(
            textInputAction: TextInputAction.search,
            value: searchTerm,
            floatingLabel: true,
            margin: const EdgeInsets.only(top: 0, bottom: 5, left: 20, right: 20),
            prefixIcon: const Icon(iconSearch),
            labelText: getMyServicesLabels(context).searchByCountryNameOrDialCode,
            labelStyle: getTextTheme(context).bodySmall,
            onChanged: (t) => setState(() => searchTerm = t),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              children: countries
                  .map(
                    (e) => CountryWidget(
                      country: e,
                      onCountrySelect: widget.onCountrySelect,
                      showDialCode: widget.showDialCode,
                      popOnSelect: widget.popOnSelect,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CountryWidget extends StatelessWidget {
  const CountryWidget({
    super.key,
    required this.country,
    this.showDialCode = true,
    this.popOnSelect = true,
    this.onCountrySelect,
  });

  final Country country;
  final bool showDialCode;
  final bool popOnSelect;
  final ValueChanged<Country>? onCountrySelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onCountrySelect != null
          ? () {
              onCountrySelect!(country);
              if (popOnSelect) {
                pop();
              }
            }
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      title: Text(country.localeName()),
      subtitle: showDialCode
          ? Row(
              children: [
                Text(
                  country.dialCode ?? "",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                ),
              ],
            )
          : null,
      horizontalTitleGap: 4,
      leading: CountryEmoji(country: country, showDialCode: false),
    );
  }
}

class CountryEmoji extends StatelessWidget {
  const CountryEmoji({
    super.key,
    required this.country,
    this.showDialCode = true,
  });
  final Country country;
  final bool showDialCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Builder(builder: (context) {
            if (country.code == 'all') {
              return const Icon(Mdi.earth);
            }
            return Text(country.emoji, style: getTextTheme(context).titleLarge?.copyWith(height: 0, fontWeight: FontWeight.bold));
          }),
        ),
        if (showDialCode)
          Text(
            country.dialCode ?? "",
            style: getTextTheme(context).titleMedium?.copyWith(height: 2.0, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}
