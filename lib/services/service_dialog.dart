import '../my_services.dart';

class ServiceDialog {
  ServiceDialog._();

  static dynamic show({required String title, List<Widget>? children, bool barrierDismissible = true}) {
    return showDialog<dynamic>(
        context: ServiceNav.context!,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext c) {
          return GestureDetector(
            onTap: () => barrierDismissible ? pop() : null,
            child: MyDialog(title: title, children: children),
          );
        });
  }
}

class MyDialog extends StatelessWidget {
  const MyDialog({Key? key, this.title = '', this.children}) : super(key: key);

  final String title;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {}, // this is needed to prevents taps from dismissing the dialog
          child: SimpleDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            title: Text(title, textAlign: TextAlign.center),
            children: children,
          ),
        ),
      ),
    );
  }
}
