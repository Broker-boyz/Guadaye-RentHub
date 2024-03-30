import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white)),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.blue.shade900,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade600,
    secondaryContainer: Colors.grey.shade900,
    inversePrimary: Colors.grey.shade100,
    error: Colors.white,
  ),
);
