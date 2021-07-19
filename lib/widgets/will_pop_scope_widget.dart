import '../my_services.dart';

class WillPopScopeWidget extends StatelessWidget {
  const WillPopScopeWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final labels = getMyServicesLabels(context);

    return WillPopScope(
      onWillPop: () {
        Helpers.hideSnackBar();
        Helpers.showSnackBar(
          elevation: 2,
          seconds: 2,
          content: YesSnackBarMessage(
            text: labels.areYouSureYouWantToCloseTheApp,
            onYes: SystemNavigator.pop,
          ),
        );
        return Future<bool>.value(false);
      },
      child: child,
    );
  }
}
