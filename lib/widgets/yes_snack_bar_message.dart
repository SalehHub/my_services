import '../my_services.dart';

// class YesSnackBarMessage extends StatelessWidget {
//   const YesSnackBarMessage({Key? key, this.text, this.buttonText, required this.onYes}) : super(key: key);
//
//   final String? text;
//   final String? buttonText;
//   final VoidCallback onYes;
//
//   @override
//   Widget build(BuildContext context) {
//     final labels = getMyServicesLabels(context);
//
//     print(getTheme(context).brightness);
//     // print(watchThemeMode(ref));
//     print(isDark(context));
//
//     return Row(
//       children: <Widget>[
//         Text(
//           text ?? labels.areYouSure,
//           style: getTextTheme(context).bodyText1?.copyWith(color: isDark(context) ? Colors.black : Colors.white),
//         ),
//         const Spacer(),
//         ElevatedButton(
//           style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//           onPressed: () {
//             Helpers.hideSnackBar();
//             onYes();
//           },
//           child: Text(buttonText ?? labels.yes, style: getTextTheme(context).bodyText1?.copyWith(color: Colors.white)),
//         )
//       ],
//     );
//   }
// }

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
        style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          Helpers.hideSnackBar();
          onYes();
        },
        child: Text(buttonText ?? labels?.yes ?? "Yes", style: context == null ? null : getTextTheme(context).bodyText1?.copyWith(color: Colors.white)),
      )
    ],
  );
}
