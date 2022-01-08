import '../my_services.dart';

class MyInk extends StatelessWidget {
  const MyInk({Key? key, required this.child, this.onTap, this.radius, this.borderRadius, this.margin = EdgeInsets.zero}) : super(key: key);
  final Widget child;
  final GestureTapCallback? onTap;
  final double? radius;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Stack(
        children: <Widget>[
          child,
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              borderRadius: borderRadius,
              child: InkWell(
                radius: radius,
                borderRadius: borderRadius,
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
