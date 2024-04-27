import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.deepPurple.shade400,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
    ),
    centerTitle: true,

  ),
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    background: Colors.deepPurple.shade100,
    onBackground: Colors.black,
    primaryContainer: Colors.deepPurple.shade400,
    secondaryContainer: Colors.deepOrange,
    onSecondaryContainer: Colors.white,
  ),
);


var darkTheme = ThemeData(
  useMaterial3: true, //enhance the ui

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
    ),
    centerTitle: true,
  ),

  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    background: Colors.deepPurple,
    onBackground: Colors.white,
    primaryContainer: Colors.white,
    secondaryContainer: Colors.deepOrange,
    onSecondaryContainer: Colors.white,
  ),
);
