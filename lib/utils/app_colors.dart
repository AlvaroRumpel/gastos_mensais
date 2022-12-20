import 'package:flutter/material.dart';

class AppColors {
  static const Map<int, Color> _primaryColor = {
    50: Color.fromRGBO(244, 236, 238, 1),
    100: Color.fromRGBO(220, 195, 232, 1),
    200: Color.fromRGBO(203, 165, 221, 1),
    300: Color.fromRGBO(136, 14, 79, 1),
    400: Color.fromRGBO(136, 14, 79, 1),
    500: Color.fromRGBO(142, 60, 181, 1),
    600: Color.fromRGBO(136, 14, 79, 1),
    700: Color.fromRGBO(136, 14, 79, 1),
    800: Color.fromRGBO(136, 14, 79, 1),
    900: Color.fromRGBO(60, 25, 76, 1),
  };

  static const Map<int, Color> _whiteColor = {
    50: Color.fromRGBO(244, 236, 238, 1),
    100: Color.fromRGBO(220, 195, 232, 1),
    200: Color.fromRGBO(203, 165, 221, 1),
    300: Color.fromRGBO(136, 14, 79, 1),
    400: Color.fromRGBO(136, 14, 79, 1),
    500: Color.fromRGBO(211, 211, 211, 1),
    600: Color.fromRGBO(136, 14, 79, 1),
    700: Color.fromRGBO(136, 14, 79, 1),
    800: Color.fromRGBO(136, 14, 79, 1),
    900: Color.fromRGBO(60, 25, 76, 1),
  };

  static const Map<int, Color> _redColor = {
    50: Color.fromRGBO(244, 236, 238, 1),
    100: Color.fromRGBO(241, 191, 191, 1),
    200: Color.fromRGBO(203, 165, 221, 1),
    300: Color.fromRGBO(136, 14, 79, 1),
    400: Color.fromRGBO(136, 14, 79, 1),
    500: Color.fromRGBO(209, 47, 47, 1),
    600: Color.fromRGBO(136, 14, 79, 1),
    700: Color.fromRGBO(136, 14, 79, 1),
    800: Color.fromRGBO(136, 14, 79, 1),
    900: Color.fromRGBO(60, 25, 76, 1),
  };

  static const Map<int, Color> _blackColor = {
    50: Color.fromRGBO(244, 236, 238, 1),
    100: Color.fromRGBO(241, 191, 191, 1),
    200: Color.fromRGBO(203, 165, 221, 1),
    300: Color.fromRGBO(136, 14, 79, 1),
    400: Color.fromRGBO(136, 14, 79, 1),
    500: Color.fromRGBO(38, 38, 38, 1),
    600: Color.fromRGBO(136, 14, 79, 1),
    700: Color.fromRGBO(136, 14, 79, 1),
    800: Color.fromRGBO(136, 14, 79, 1),
    900: Color.fromRGBO(60, 25, 76, 1),
  };

  static MaterialColor primary = const MaterialColor(0xFF8E3CB5, _primaryColor);
  static MaterialColor white = const MaterialColor(0xFFD3D3D3, _whiteColor);
  static MaterialColor red = const MaterialColor(0xFFD12F2F, _redColor);
  static MaterialColor black = const MaterialColor(0xFF262626, _blackColor);
}
