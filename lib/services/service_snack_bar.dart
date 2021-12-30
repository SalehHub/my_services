import '../my_services.dart';

class ServiceSnackBar {
  ServiceSnackBar._();

  static const EdgeInsets margin = EdgeInsets.symmetric(vertical: 10, horizontal: 15);

  static void showText({
    String text = '',
    Color? backgroundColor,
    EdgeInsets margin = margin,
    int seconds = 3,
    GestureTapCallback? onTap,
    bool hideShownSnackBars = false,
  }) {
    show(
      margin: margin,
      backgroundColor: backgroundColor,
      seconds: seconds,
      hideShownSnackBars: hideShownSnackBars,
      content: GestureDetector(
        onTap: onTap,
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }

  static void hide() {
    final BuildContext? context = ServiceNav.context;
    if (context != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  static void show({
    required Widget content,
    BuildContext? context,
    Color? backgroundColor,
    EdgeInsets margin = margin,
    int seconds = 3,
    bool hideShownSnackBars = false,
  }) {
    try {
      if (hideShownSnackBars) {
        hide();
      }

      final BuildContext? _context = context ?? ServiceNav.context;
      if (_context != null) {
        ScaffoldMessenger.of(_context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: seconds),
            backgroundColor: backgroundColor,
            margin: margin,
            content: content,
          ),
        );
      }
    } catch (e, s) {
      logger.e(e, e, s);
    }
  }

  static void showSnackBarYesQuestion({String? questionText, String? buttonText, required VoidCallback onYes, bool hideShownSnackBars = false}) {
    show(
      hideShownSnackBars: hideShownSnackBars,
      content: YesSnackBarMessage(
        text: questionText,
        buttonText: buttonText,
        onYes: () {
          hide();
          onYes();
        },
      ),
    );
  }
}
