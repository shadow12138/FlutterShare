import 'dart:ui';

class Utils {
  static Color getColorFromHex(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) hex = "ff" + hex;
    return Color(int.parse(hex, radix: 16));
  }
}
