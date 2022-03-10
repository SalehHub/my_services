import '../my_services.dart';

class CopyTextWidget extends StatelessWidget {
  const CopyTextWidget({Key? key, required this.textToCopy, required this.child}) : super(key: key);

  final String textToCopy;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    MyServicesLocalizationsData labels = getMyServicesLabels(context);

    return GestureDetector(
      key: const ValueKey("copyBtn"),
      onTap: () {
        Clipboard.setData(ClipboardData(text: textToCopy));
        MyServices.services.snackBar.showText(text: labels.textHasBeenCopied, success: true);
      },
      child: child,
    );
  }
}
