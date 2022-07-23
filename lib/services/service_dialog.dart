import '../my_services.dart';

class ServiceDialog {
  const ServiceDialog();

  Future<T?> show<T>({String? title, List<Widget>? children, Widget? child, bool barrierDismissible = true, EdgeInsets? insetPadding, EdgeInsets? contentPadding}) {
    return showDialog<T?>(
      context: MyServices.context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext c) {
        return GestureDetector(
          onTap: () => barrierDismissible ? pop(false) : null,
          child: MyDialog(title: title, child: child, children: children, insetPadding: insetPadding, contentPadding: contentPadding),
        );
      },
    );
  }

  Future<bool?> showYesNo({
    String? title,
    String? questionText,
    String? buttonText,
    required VoidCallback onYes,
    bool? success = false,
    bool barrierDismissible = true,
  }) {
    return show(title: title, barrierDismissible: barrierDismissible, children: [
      Builder(builder: (context) {
        final MyServicesLocalizationsData labels = getMyServicesLabels(context);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(questionText ?? labels.areYouSure, style: getTextTheme(context).titleMedium),
              ),
              Row(
                children: [
                  TextButton(
                    child: Text(
                      getMyServicesLabels(context).cancel,
                      style: getTextTheme(context).titleMedium?.copyWith(color: Colors.green),
                    ),
                    onPressed: () => pop(false),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      onYes();
                      pop(true);
                    },
                    child: Text(
                      getMyServicesLabels(context).continue1,
                      style: getTextTheme(context).titleMedium?.copyWith(color: Colors.red.shade800),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      })
    ]);
  }
}

class MyDialog extends StatelessWidget {
  const MyDialog({
    super.key,
    this.title = '',
    this.children,
    this.child,
    this.insetPadding,
    this.contentPadding,
  });

  final String? title;
  final List<Widget>? children;
  final Widget? child;
  final EdgeInsets? insetPadding;
  final EdgeInsets? contentPadding;

  Widget dialog(BuildContext context) {
    EdgeInsets nContentPadding = contentPadding ?? const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0);
    EdgeInsets nInsetPadding = insetPadding ?? const EdgeInsets.symmetric(horizontal: 40, vertical: 24);
    MyText? nTitle = title != null ? MyText(title, textAlign: TextAlign.center) : null;

    if (children != null) {
      return SimpleDialog(
        contentPadding: nContentPadding,
        insetPadding: nInsetPadding,
        title: nTitle,
        children: children,
      );
    }

    return AlertDialog(
      contentPadding: nContentPadding,
      insetPadding: nInsetPadding,
      title: nTitle,
      content: SizedBox(
        width: double.maxFinite, //width: double.maxFinite in case the child was a ListView
        child: Unfocus(child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {}, // this is needed to prevents taps from dismissing the dialog
          child: dialog(context),
        ),
      ),
    );
  }
}
