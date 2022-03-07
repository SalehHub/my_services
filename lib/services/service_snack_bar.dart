import '../my_services.dart';

class ServiceSnackBar {
  ServiceSnackBar._();
  static const EdgeInsets margin = EdgeInsets.symmetric(vertical: 10, horizontal: 15);

  static fgColor(bool? success) {
    if (success == true) {
      return getColorScheme(ServiceNav.context).onTertiary;
    } else if (success == false) {
      return getColorScheme(ServiceNav.context).onError;
    }

    return getColorScheme(ServiceNav.context).onPrimary;
  }

  static bgColor(bool? success) {
    if (success == true) {
      return getColorScheme(ServiceNav.context).tertiary;
    } else if (success == false) {
      return getColorScheme(ServiceNav.context).error;
    }

    return getColorScheme(ServiceNav.context).primary;
  }

  static void hide() {
    ScaffoldMessenger.of(ServiceNav.context).hideCurrentSnackBar();
  }

  static void showText({
    String text = '',
    bool? success,
    int seconds = 3,
    GestureTapCallback? onTap,
    bool hideShownSnackBars = false,
  }) {
    show(
      margin: margin,
      seconds: seconds,
      hideShownSnackBars: hideShownSnackBars,
      success: success,
      content: GestureDetector(
        onTap: onTap,
        child: Text(text, textAlign: TextAlign.center, style: getTextTheme(ServiceNav.context).bodyText1?.copyWith(color: fgColor(success))),
      ),
    );
  }

  static ScaffoldFeatureController? show({
    required Widget content,
    EdgeInsets margin = margin,
    int seconds = 3,
    bool hideShownSnackBars = false,
    bool? success,
  }) {
    try {
      if (hideShownSnackBars) {
        hide();
      }

      final BuildContext context = ServiceNav.context;

      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: seconds),
          backgroundColor: bgColor(success),
          margin: margin,
          content: content,
        ),
      );
    } catch (e, s) {
      logger.e(e, e, s);
    }
    return null;
  }

  static void showYesQuestion({
    String? questionText,
    String? buttonText,
    required VoidCallback onYes,
    bool hideShownSnackBars = true,
    bool? success = false,
  }) {
    show(
      success: success,
      hideShownSnackBars: hideShownSnackBars,
      content: YesSnackBarMessage(
        text: questionText,
        buttonText: buttonText,
        success: success,
        onYes: () {
          hide(); // hide myself
          onYes();
        },
      ),
    );
  }
}
