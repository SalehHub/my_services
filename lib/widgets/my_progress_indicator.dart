import '../my_services.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({
    super.key,
    this.margin = EdgeInsets.zero,
    this.width,
    this.height,
  });

  final EdgeInsets margin;
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
          child: Builder(builder: (context) {
            if (getTheme(context).platform == TargetPlatform.android) {
              return SizedBox(
                width: width != null ? (width! - 25.0) : null,
                height: height != null ? (height! - 25.0) : null,
                child: const CircularProgressIndicator(),
              );
            }

            return CircularProgressIndicator.adaptive(
              backgroundColor: getColor(
                context,
                colorWhenDark: getColorScheme(context).primaryContainer,
                colorWhenLight: getColorScheme(context).onPrimaryContainer,
              ),
            );
          }),
        ),
      ),
    );
  }
}
