import '../my_services.dart';

Widget yesSnackBarMessage({String? text, String? buttonText, required VoidCallback onYes}) {
  final BuildContext? context = ServiceNav.context;
  final MyServicesLocalizationsData? labels = context != null ? getMyServicesLabels(context) : null;

  return Row(
    children: <Widget>[
      Text(
        text ?? labels?.areYouSure ?? "",
        style: context == null ? null : getTextTheme(context).bodyText1?.copyWith(color: isDark(context) ? Colors.black : Colors.white),
      ),
      const Spacer(),
      ElevatedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: () {
          ServiceSnackBar.hideSnackBar();
          onYes();
        },
        child: Text(buttonText ?? labels?.yes ?? "Yes",
            style: context == null
                ? null
                : getTextTheme(context).bodyText1?.copyWith(
                      // shadows: Helpers.getTextStroke(0.1, Colors.black),
                      color: Colors.white,
                    )),
      )
    ],
  );
}
