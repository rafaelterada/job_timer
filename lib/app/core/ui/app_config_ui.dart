import 'package:flutter/material.dart';

class AppConfigUI {
  AppConfigUI._();

  static const MaterialColor _primarySwatch = MaterialColor(0xFF9A1421, {
    50: Color(0xFF8b121e),
    100: Color(0xFF7b101a),
    200: Color(0xFF6c0e17),
    300: Color(0xFF5c0c14),
    400: Color(0xFF4d0a11),
    500: Color(0xFF3e080d),
    600: Color(0xFF2e060a),
    700: Color(0xFF1f0407),
    800: Color(0xFF0f0203),
    900: Color(0xFF000000),
  });

  static final ThemeData theme = ThemeData(
      primarySwatch: _primarySwatch,
      primaryColor: const Color(0xFF9A1421),
      primaryColorLight: const Color(0xFFED4C5C),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        labelStyle: const TextStyle(color: Color(0xFF9A1421)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))));
}
