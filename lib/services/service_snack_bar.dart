import '../my_services.dart';

class ServiceSnackBar {
  static const ServiceSnackBar _s = ServiceSnackBar._();
  factory ServiceSnackBar() => _s;
  const ServiceSnackBar._();
  //
  static const EdgeInsets _margin = EdgeInsets.symmetric(vertical: 10, horizontal: 15);

  fgColor(bool? success) {
    if (success == true) {
      return getColorScheme(MyServices.context).onTertiary;
    } else if (success == false) {
      return getColorScheme(MyServices.context).onError;
    }

    return getColorScheme(MyServices.context).onPrimary;
  }

  bgColor(bool? success) {
    if (success == true) {
      return getColorScheme(MyServices.context).tertiary;
    } else if (success == false) {
      return getColorScheme(MyServices.context).error;
    }

    return getColorScheme(MyServices.context).primary;
  }

  void hide() {
    ScaffoldMessenger.of(MyServices.context).removeCurrentSnackBar();
  }

  void showText({
    String text = '',
    bool? success,
    int seconds = 3,
    GestureTapCallback? onTap,
    bool hideShownSnackBars = false,
  }) {
    show(
      margin: _margin,
      seconds: seconds,
      hideShownSnackBars: hideShownSnackBars,
      success: success,
      content: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          textDirection: MyServices.helpers.getTextDirection(text),
          style: getTextTheme(MyServices.context).bodyText1?.copyWith(color: fgColor(success)),
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? show({
    required Widget content,
    EdgeInsets margin = _margin,
    int seconds = 3,
    bool hideShownSnackBars = false,
    bool? success,
  }) {
    try {
      if (hideShownSnackBars) {
        hide();
      }

      return ScaffoldMessenger.of(MyServices.context).showSnackBar(
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

  Future<bool> showYesQuestion({
    String? questionText,
    String? buttonText,
    required VoidCallback onYes,
    bool hideShownSnackBars = true,
    bool? success = false,
  }) async {
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? res = show(
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

    //check out WillPopScopeWidget
    //TODO: not a good solution // the snackbar can be hidden without clicking yes button
    if (res != null) {
      if ((await res.closed) == SnackBarClosedReason.remove) {
        return true;
      }
    }
    return false;
  }
}
