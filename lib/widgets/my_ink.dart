import '../my_services.dart';

class MyInk extends StatelessWidget {
  const MyInk({Key? key, required this.child, this.onTap, this.radius, this.borderRadius}) : super(key: key);
  final Widget child;
  final GestureTapCallback? onTap;
  final double? radius;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              radius: radius,
              borderRadius: borderRadius,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
