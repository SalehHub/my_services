import '../my_services.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({
    super.key,
    this.margin = EdgeInsets.zero,
    this.size,
  });

  final EdgeInsets margin;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Padding(
          padding: margin,
          child: Builder(builder: (context) {
            double? width = size;
            double? height = size;

            if (width != null) {
              width = width - 25.0;
              if (width < 0) {
                width = null;
              }
            }

            if (height != null) {
              height = height - 25.0;
              if (height < 0) {
                height = null;
              }
            }

            //
            if (getTheme(context).platform == TargetPlatform.android) {
              return SizedBox(
                width: width,
                height: height,
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
