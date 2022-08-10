import '../my_services.dart';

class MyButton extends ConsumerWidget {
  const MyButton({
    super.key,
    this.id,
    required this.text,
    this.textStyle,
    this.child,
    this.onPressed,
    this.isTextButton = false,
    this.withLoading = true,
    this.circle = false,
  });
  final String text;
  final TextStyle? textStyle;
  final Widget? child;
  final dynamic id;
  final bool withLoading;
  final bool circle;
  final bool isTextButton;
  final AsyncCallback? onPressed;
  final double progressIndicatorSize = 20;

  String get _id => MyServices.helpers.getMd5((id ?? text).toString());

  Widget _child(BuildContext context, WidgetRef ref) {
    if (withLoading) {
      if (MyServices.services.loader.isLoading(ref, _id)) {
        return MyProgressIndicator(size: progressIndicatorSize);
      }
    }

    if (child != null) {
      return child!;
    }

    return MyText(text, style: textStyle);
  }

  Future<AsyncCallback?> _onPressed(BuildContext context, WidgetRef ref) async {
    if (onPressed != null) {
      if (withLoading) {
        if (MyServices.services.loader.isLoading(ref, _id)) {
          return Future.value();
        }
        MyServices.services.loader.setLoading(_id, true);
      }

      try {
        await onPressed!();
      } catch (e, s) {
        logger.e(e, e, s);
      }

      if (withLoading) {
        MyServices.services.loader.setLoading(_id, false);
      }
    }
    return null;
  }

  Widget _button(BuildContext context, WidgetRef ref) {
    if (circle) {
      return MyContainer(
        onTap: () => _onPressed(context, ref),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        width: progressIndicatorSize * 1.5,
        height: progressIndicatorSize * 1.5,
        bgColor: Colors.black45,
        margin: const EdgeInsets.all(2),
        child: _child(context, ref),
      );
    }

    if (isTextButton) {
      return TextButton(
        onPressed: () => _onPressed(context, ref),
        child: _child(context, ref),
      );
    }

    return ElevatedButton(
      onPressed: () => _onPressed(context, ref),
      child: _child(context, ref),
    );
  }

  Widget _animated(BuildContext context, WidgetRef ref) {
    if (withLoading) {
      return AnimatedSize(
        // alignment: Alignment.centerLeft,
        duration: const Duration(milliseconds: 200),
        child: _button(context, ref),
      );
    }

    return _button(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _animated(context, ref);
  }
}
