import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade200,
    primary: Colors.grey.shade100,
    secondary: Colors.white,
    secondaryContainer: Colors.grey.shade300,
    inversePrimary: Colors.black,
    error: Colors.blue,
  ),
 
);
