//pinCodeFields
import 'package:my_services/my_services.dart';

class MyPinCodeField extends StatelessWidget {
  const MyPinCodeField({
    super.key,
    this.onCompleted,
    this.length = 4,
    this.onChanged,
    this.margin = EdgeInsets.zero,
    this.controller,
    this.digitsOnly = false,
  });

  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry margin;
  final TextEditingController? controller;
  final int length;
  final bool digitsOnly;

  @override
  Widget build(BuildContext context) {
    // final Color color = getTheme(context).toggleableActiveColor;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: getTextTheme(context).headlineSmall,
      decoration: BoxDecoration(
        border: Border.all(color: getColorScheme(context).primary),
        borderRadius: MyServices.services.theme.borderRadius,
      ),
    );

    return Padding(
      padding: margin,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          controller: controller,
          keyboardType: digitsOnly ? TextInputType.number : TextInputType.visiblePassword,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          // textStyle: getTextTheme(context).bodyText1,
          // cursorColor: color,
          // appContext: context,
          length: length,
          inputFormatters: [
            if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(length),
          ],
          onCompleted: onCompleted,
          onChanged: onChanged ?? (t) {},
          //theme
          defaultPinTheme: defaultPinTheme,
        ),
      ),
    );
  }
}
