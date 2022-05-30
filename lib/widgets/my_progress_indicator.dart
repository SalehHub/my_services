import '../my_services.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({super.key, this.color, this.margin = EdgeInsets.zero, this.width, this.height});

  final EdgeInsets margin;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Padding(
          padding: margin,
          child: CircularProgressIndicator.adaptive(backgroundColor: color),
        ),
      ),
    );
  }
}
