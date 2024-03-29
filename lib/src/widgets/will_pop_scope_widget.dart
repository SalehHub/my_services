import '../../my_services.dart';

class WillPopScopeWidget extends StatelessWidget {
  const WillPopScopeWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final labels = getMyServicesLabels(context);

    return WillPopScope(
      onWillPop: () {
        MyServices.services.snackBar.show(
          seconds: 2,
          hideShownSnackBars: true,
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
