import 'package:flutter/material.dart';

class ThemeColor {
  static const Color title = const Color(0xff5a5d85);
  static const Color subTitle = const Color(0xff7972558);
  static const Color primary = Color(0xff7a81dd);
  static const Color accent = Color(0xff7178d3);
  static const Color primaryAccent = Color(0xff494c79);
  static const Color lightPurple = Color(0xff7e57c2);
  static const Color darkAccent = Color(0xFF333366);

  static const MaterialColor primaryAccentSwatch = MaterialColor(0xff494c79, {
    050: Color.fromRGBO(255, 255, 255, 0.1),
    100: Color.fromRGBO(255, 255, 255, 0.2),
    200: Color.fromRGBO(255, 255, 255, 0.3),
    300: Color.fromRGBO(255, 255, 255, 0.4),
    400: Color.fromRGBO(255, 255, 255, 0.5),
    500: Color.fromRGBO(255, 255, 255, 0.6),
    600: Color.fromRGBO(255, 255, 255, 0.7),
    700: Color.fromRGBO(255, 255, 255, 0.8),
    800: Color.fromRGBO(255, 255, 255, 0.9),
    900: Color.fromRGBO(255, 255, 255, 1.0),
  });
}
