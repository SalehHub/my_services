//pinCodeFields
import 'package:my_services/my_services.dart';

class MyPinCodeField extends StatelessWidget {
  const MyPinCodeField({
    super.key,
    this.onCompleted,
    this.length = 4,
    this.onChanged,
    this.onClipboardFound,
    this.margin = EdgeInsets.zero,
    this.controller,
    this.digitsOnly = false,
  });

  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onClipboardFound;
  final EdgeInsetsGeometry margin;
  final TextEditingController? controller;
  final int length;
  final bool digitsOnly;

  @override
  Widget build(BuildContext context) {
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
          onClipboardFound: onClipboardFound,
          enableSuggestions: false,

          autofillHints: const [AutofillHints.oneTimeCode],
          keyboardType: digitsOnly ? TextInputType.number : TextInputType.visiblePassword,

          //android only
          // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          //android only
          // smsCodeMatcher: '\\d{$length}',
          //android only
          // listenForMultipleSmsOnAndroid: true,

          //
          controller: controller,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          length: length,
          inputFormatters: [
            if (digitsOnly) FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-١]')),
            LengthLimitingTextInputFormatter(length),
          ],
          onCompleted: onCompleted,
          onChanged: onChanged,
          //theme
          defaultPinTheme: defaultPinTheme,
        ),
      ),
    );
  }
}
