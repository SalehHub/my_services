import '../my_services.dart';

class ServiceDialog {
  const ServiceDialog._();
  static const ServiceDialog _s = ServiceDialog._();
  factory ServiceDialog() => _s;
  //
  static dynamic show({required String title, List<Widget>? children, Widget? child, bool barrierDismissible = true, EdgeInsets? insetPadding, EdgeInsets? contentPadding}) {
    return showDialog<dynamic>(
        context: ServiceNav.context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext c) {
          return GestureDetector(
            onTap: () => barrierDismissible ? pop() : null,
            child: MyDialog(title: title, child: child, children: children, insetPadding: insetPadding, contentPadding: contentPadding),
          );
        });
  }
}

class MyDialog extends StatelessWidget {
  const MyDialog({
    Key? key,
    this.title = '',
    this.children,
    this.child,
    this.insetPadding,
    this.contentPadding,
  }) : super(key: key);

  final String title;
  final List<Widget>? children;
  final Widget? child;
  final EdgeInsets? insetPadding;
  final EdgeInsets? contentPadding;

  Widget dialog(BuildContext context) {
    if (children != null) {
      return SimpleDialog(
        contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
        insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        title: Text(title, textAlign: TextAlign.center),
        children: children,
      );
    }
    return AlertDialog(
      contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
      insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      title: Text(title, textAlign: TextAlign.center),
      content: SizedBox(width: double.maxFinite, child: child), //width: double.maxFinite in case the child was a ListView
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
