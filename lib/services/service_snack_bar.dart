import '../my_services.dart';

class ServiceSnackBar {
  static void showTextSnackBar({
    String text = '',
    Color? backgroundColor,
    double elevation = 3.0,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    EdgeInsets margin = const EdgeInsets.all(10),
    int seconds = 3,
    GestureTapCallback? onTap,
    bool hideShownSnackBars = false,
  }) {
    //Scaffold.of(context)
    showSnackBar(
      margin: margin,
      backgroundColor: backgroundColor ?? Colors.green.shade800,
      elevation: elevation,
      behavior: behavior,
      seconds: seconds,
      hideShownSnackBars: hideShownSnackBars,
      content: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  static void hideSnackBar() {
    final BuildContext? context = ServiceNav.context;
    if (context != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  static void showSnackBar({
    required Widget content,
    BuildContext? context,
    Color? backgroundColor = Colors.black,
    double elevation = 3.0,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    EdgeInsets margin = const EdgeInsets.all(10),
    int seconds = 3,
    bool hideShownSnackBars = false,
  }) {
    try {
      if (hideShownSnackBars) {
        ServiceSnackBar.hideSnackBar();
      }

      final BuildContext? _context = context ?? ServiceNav.context;
      if (_context != null) {
        ScaffoldMessenger.of(_context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: seconds),
            margin: margin,
            backgroundColor: backgroundColor,
            elevation: elevation,
            behavior: behavior,
            content: content,
          ),
        );
      }
    } catch (e, s) {
      logger.e(e, e, s);
    }
  }

  static void showSnackBarYesQuestion({String? questionText, String? buttonText, required VoidCallback onYes, bool hideShownSnackBars = false}) {
    showSnackBar(
      hideShownSnackBars: hideShownSnackBars,
      backgroundColor: null,
      content: yesSnackBarMessage(
        text: questionText,
        buttonText: buttonText,
        onYes: () {
          hideSnackBar();
          onYes();
        },
      ),
    );
  }
}
