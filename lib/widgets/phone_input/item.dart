import '../../my_services.dart';
import 'util.dart';

/// [Item]
class Item extends StatelessWidget {
  final Country country;
  final bool showFlag;
  final bool useEmoji;
  final TextStyle? textStyle;
  final bool withCountryNames;
  final double? leadingPadding;
  final bool trailingSpace;

  const Item({
    Key? key,
    required this.country,
    this.showFlag = false,
    this.useEmoji = true,
    this.textStyle,
    this.withCountryNames = false,
    this.leadingPadding = 12,
    this.trailingSpace = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dialCode = (country.dialCode ?? '');
    if (trailingSpace) {
      dialCode = dialCode.padRight(5, "   ");
    }

    return Container(
      width: 25,
      color: Colors.transparent,
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.transparent,
            child: Text(
              Utils.generateFlagEmojiUnicode(country.alpha2Code ?? '')
              // + " " + dialCode
              ,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: getTextTheme(context).headline5?.copyWith(height: 1.2),
            ),
          ),
          // const Text(" - "),
        ],
      ),
    );

    // return Row(
    //   textDirection: TextDirection.ltr,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.min,
    //   children: <Widget>[
    //     SizedBox(width: leadingPadding),
    //     _Flag(
    //       country: country,
    //       showFlag: showFlag,
    //       useEmoji: useEmoji,
    //     ),
    //     // SizedBox(width: 12.0),
    //     Text(
    //       dialCode,
    //       // textDirection: TextDirection.ltr,
    //       style: textStyle,
    //     ),
    //   ],
    // );
  }
}

// class _Flag extends StatelessWidget {
//   final Country country;
//   final bool showFlag;
//   final bool useEmoji;
//
//   const _Flag({Key? key, required this.country, this.showFlag = true, this.useEmoji = true}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return showFlag
//         ? Container(
//             // color: Colors.red,
//             alignment: Alignment.center,
//             width: 50,
//             child: useEmoji
//                 ? Text(
//                     Utils.generateFlagEmojiUnicode(country.alpha2Code ?? ''),
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.headline5?.copyWith(height: 1.3),
//                   )
//                 : Image.asset(
//                     country.flagUri,
//                     width: 32.0,
//                     package: 'intl_phone_number_input',
//                     errorBuilder: (context, error, stackTrace) {
//                       return const SizedBox.shrink();
//                     },
//                   ),
//           )
//         : const SizedBox.shrink();
//   }
// }
