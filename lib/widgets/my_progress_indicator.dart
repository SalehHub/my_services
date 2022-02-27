import '../my_services.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({Key? key, this.color, this.margin = EdgeInsets.zero, this.width, this.height}) : super(key: key);

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
          child: const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
