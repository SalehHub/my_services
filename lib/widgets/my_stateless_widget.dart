import '../my_services.dart';

//horrible solution
Map<String, BuildContext> _sc = {};

abstract class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  BuildContext get context => _sc[runtimeType.toString()]!;

  /////Theme
  ThemeData get theme => Theme.of(context);
  TextTheme get textTheme => theme.textTheme;
  bool get isDarkTheme => theme.brightness == Brightness.dark;

  /////local
  MyServicesLocalizationsData get myServicesLabels => getMyServicesLabels(context);

  //////Page Size & Orientation
  MediaQueryData get mediaQueryData => MediaQuery.of(context);
  Orientation get pageOrientation => mediaQueryData.orientation;
  bool get isPageOrientationLandScape => pageOrientation == Orientation.landscape;
  bool get isPageOrientationPortrait => pageOrientation == Orientation.portrait;
  Size get pageSize => mediaQueryData.size;
  double get pageHeight => pageSize.height;
  double get pageWidth => pageSize.width;

  @override
  Widget build(BuildContext context) {
    _sc.addAll({runtimeType.toString(): context});
    return myBuild(context);
  }

  @protected
  Widget myBuild(BuildContext context);
}
