import '../my_services.dart';

class MyButton extends ConsumerWidget {
  const MyButton({Key? key, this.id, required this.text, this.onPressed, this.color, this.isTextButton = false, this.isLoading = true}) : super(key: key);
  final String text;
  final String? id;
  final Color? color;
  final bool isLoading;
  final bool isTextButton;
  final AsyncCallback? onPressed;

  Widget _child(BuildContext context, WidgetRef ref) {
    if (isLoading) {
      if (ServiceLoader.isLoading(ref, Helpers.getMd5(id ?? text))) {
        return const MyProgressIndicator(color: Colors.white);
      }
    }

    return MyText(text);
  }

  Future<AsyncCallback?> _onPressed(BuildContext context, WidgetRef ref) async {
    if (onPressed != null) {
      if (isLoading) {
        ServiceLoader.setLoading(ref, Helpers.getMd5(id ?? text), true);
      }

      try {
        await onPressed!();
      } catch (e, s) {
        logger.e(e, s);
      }

      if (isLoading) {
        ServiceLoader.setLoading(ref, Helpers.getMd5(id ?? text), false);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isTextButton) {
      return TextButton(onPressed: () => _onPressed(context, ref), child: _child(context, ref));
    }

    return ElevatedButton(onPressed: () => _onPressed(context, ref), child: _child(context, ref));
  }
}
