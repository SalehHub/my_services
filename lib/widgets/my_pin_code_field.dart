//pinCodeFields
import 'package:my_services/my_services.dart';

class MyPinCodeField extends StatelessWidget {
  const MyPinCodeField({super.key, this.onCompleted, this.length = 4, this.onChanged, this.margin = EdgeInsets.zero});

  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry margin;
  final int length;

  @override
  Widget build(BuildContext context) {
    final Color color = getTheme(context).toggleableActiveColor;
    return Padding(
      padding: margin,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          textStyle: getTextTheme(context).bodyText1,
          cursorColor: color,
          appContext: context,
          length: length,
          onCompleted: onCompleted,
          onChanged: onChanged ?? (t) {},
          //theme
          pinTheme: PinTheme.defaults(
            shape: PinCodeFieldShape.circle,
            inactiveColor: color.withOpacity(0.7),
            selectedColor: color,
          ),
        ),
      ),
    );
  }
}
