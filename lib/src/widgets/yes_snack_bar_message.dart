import '../../my_services.dart';

class YesSnackBarMessage extends StatelessWidget {
  const YesSnackBarMessage({super.key, this.text, this.buttonText, required this.onYes, this.icon, this.success});
  final String? text;
  final String? buttonText;
  final VoidCallback onYes;
  final IconData? icon;
  final bool? success;

  @override
  Widget build(BuildContext context) {
    final MyServicesLocalizationsData labels = getMyServicesLabels(context);

    return Row(
      children: <Widget>[
        if (icon != null) ...[
          Icon(icon),
          const SizedBox(width: 5),
        ],
        Expanded(
          child: Text(
            text ?? labels.areYouSure,
            style: getTextTheme(context).bodyLarge?.copyWith(color: MyServices.services.snackBar.fgColor(success)),
          ),
        ),
        ElevatedButton(
          style: OutlinedButton.styleFrom(backgroundColor: MyServices.services.snackBar.fgColor(success)),
          onPressed: () => onYes(),
          child: Text(
            buttonText ?? labels.yes,
            style: getTextTheme(context).bodyLarge?.copyWith(color: MyServices.services.snackBar.bgColor(success)),
          ),
        )
      ],
    );
  }
}
