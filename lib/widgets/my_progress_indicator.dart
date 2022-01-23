import '../my_services.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({Key? key, this.color, this.margin = EdgeInsets.zero, this.width, this.height}) : super(key: key);

  final EdgeInsets margin;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // if (Platform.isIOS) {
    //   return const Center(child: CupertinoActivityIndicator());
    // }
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Padding(
          padding: margin,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(getTheme(context).toggleableActiveColor),
            backgroundColor: color ?? (isDark(context) ? Colors.white : null),
          ),
        ),
      ),
    );
  }
}
