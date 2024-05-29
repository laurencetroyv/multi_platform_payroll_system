import 'package:flutter/material.dart';

class ApplicationTheme {
  static ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  set themeModeTo(ThemeMode themeMode) {
    _themeMode = themeMode;
  }

  ThemeData get lightTheme => _lightTheme;
  static final ThemeData _lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
  );

  ThemeData get darkTheme => _darkTheme;
  static final ThemeData _darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
  );
}
