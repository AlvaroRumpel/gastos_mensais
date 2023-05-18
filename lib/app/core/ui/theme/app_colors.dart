import 'package:flutter/material.dart';

extension AppColors on Colors {
  static const Map<int, Color> _primaryColor = {
    50: Color(0xFFF4E6FF),
    100: Color(0xFFDECAFF),
    200: Color(0xFFC29FFF),
    300: Color(0xFFA275FF),
    400: Color(0xFF904FFF),
    500: Color(0xFF8E3CB5),
    600: Color(0xFF812E9A),
    700: Color(0xFF73207E),
    800: Color(0xFF651265),
    900: Color(0xFF550F4D),
  };

  static const Map<int, Color> _whiteColor = {
    50: Color(0xFFF5F5F5),
    100: Color(0xFFEEEEEE),
    200: Color(0xFFE0E0E0),
    300: Color(0xFFCFCFCF),
    400: Color(0xFFBDBDBD),
    500: Color(0xFFD3D3D3),
    600: Color(0xFF9E9E9E),
    700: Color(0xFF757575),
    800: Color(0xFF616161),
    900: Color(0xFF424242),
  };

  static const Map<int, Color> _redColor = {
    50: Color(0xFFFFE4E4),
    100: Color(0xFFFFC4C4),
    200: Color(0xFFFF9B9B),
    300: Color(0xFFFF7070),
    400: Color(0xFFFF4D4D),
    500: Color(0xFFD12F2F),
    600: Color(0xFFB91E1E),
    700: Color(0xFFA11414),
    800: Color(0xFF8F0A0A),
    900: Color(0xFF6F0000),
  };

  static const Map<int, Color> _blackColor = {
    50: Color(0xFFE6E6E6),
    100: Color(0xFFBFBFBF),
    200: Color(0xFF999999),
    300: Color(0xFF737373),
    400: Color(0xFF595959),
    500: Color(0xFF262626),
    600: Color(0xFF212121),
    700: Color(0xFF1B1B1B),
    800: Color(0xFF151515),
    900: Color(0xFF0B0B0B),
  };

  static const Map<int, Color> _yellowColor = {
    50: Color(0xFFFFF6D9),
    100: Color(0xFFFFE6B2),
    200: Color(0xFFFFD48C),
    300: Color(0xFFFFC066),
    400: Color(0xFFFFB34D),
    500: Color(0xFFCEB429),
    600: Color(0xFFB39424),
    700: Color(0xFF9E841F),
    800: Color(0xFF89731A),
    900: Color(0xFF6D5F12),
  };

  static const primary = MaterialColor(0xFF8E3CB5, _primaryColor);
  static const white = MaterialColor(0xFFD3D3D3, _whiteColor);
  static const red = MaterialColor(0xFFD12F2F, _redColor);
  static const black = MaterialColor(0xFF262626, _blackColor);
  static const yellow = MaterialColor(0xFFCEB429, _yellowColor);
}
