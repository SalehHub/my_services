import '../my_services.dart';

class ServiceColor {
  // static const ServiceColor _s = ServiceColor._();
  // factory ServiceColor() => _s;
  // const ServiceColor._();
  const ServiceColor();
  //
  List<Color> getRandomColors(int length, {bool dark = false}) {
    const List<MaterialAccentColor> accentsColors = Colors.accents;
    const List<MaterialColor> primariesColors = Colors.primaries;
    final List<ColorSwatch<int>> allColors = <ColorSwatch<int>>[...accentsColors, ...primariesColors];
    return Iterable<int>.generate(length).map((int e) {
      if (dark) {
        return primariesColors[Random().nextInt(primariesColors.length)].shade900;
      }
      return allColors[Random().nextInt(allColors.length)].withOpacity(0.1);
    }).toList();
  }

  Color darkenColor(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final HSLColor hsl = HSLColor.fromColor(color);
    final HSLColor hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lightenColor(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final HSLColor hsl = HSLColor.fromColor(color);
    final HSLColor hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

//generate color from text
  Color colorFromText(String text, {bool light = true, double amount = 0.25}) {
    int hash = 0;
    for (int i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final int finalHash = hash.abs() % (256 * 256 * 256);
    //print(finalHash);
    final int red = (finalHash & 0xFF0000) >> 16;
    final int blue = (finalHash & 0xFF00) >> 8;
    final int green = finalHash & 0xFF;
    final Color color = Color.fromRGBO(red, green, blue, light ? 0.1 : 1);
    return light ? color : darkenColor(color, amount);
  }

  Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((darker ? (hsl.lightness - value) : (hsl.lightness + value)).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color,
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
