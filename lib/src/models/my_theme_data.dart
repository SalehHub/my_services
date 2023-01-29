import '../../my_services.dart';

part 'my_theme_data.freezed.dart';

@freezed
class MyThemeData with _$MyThemeData {
  const MyThemeData._();

  static const MyThemeData light = MyThemeData(
    background: Colors.white,
    onBackground: Colors.black,
    //
    error: Color(0xffffb4a9),
    onError: Color(0xff680003),
    //
    success: Color(0xffDDFFD6),
    onSuccess: Color(0xff175800),
  );
  static const MyThemeData dark = MyThemeData(
    background: Colors.black,
    onBackground: Colors.white,
    //
    error: Color(0xffba1b1b),
    onError: Color(0xffffffff),
    //
    success: Color(0xff175800),
    onSuccess: Color(0xffDDFFD6),
  );

  const factory MyThemeData({
    @Default(Colors.black) Color background,
    @Default(Colors.white) Color onBackground,
    //
    @Default(Colors.green) Color primary,
    @Default(Colors.white) Color onPrimary,
    //
    @Default(Colors.white) Color card,
    @Default(Colors.green) Color onCard,
    //
    @Default(Color(0xffFFE5E5)) Color error,
    @Default(Color(0xff750000)) Color onError,
    //
    @Default(Color(0xffDDFFD6)) Color success,
    @Default(Color(0xff175800)) Color onSuccess,
    AppBarTheme? appBar,
  }) = _MyThemeData;
}
