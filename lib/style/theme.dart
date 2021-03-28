import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  primaryColor: primaryColor,
  fontFamily: 'Poppins',
  textTheme: TextTheme(
    headline6: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    button: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  iconTheme: IconThemeData(color: Colors.white),
  primaryIconTheme: IconThemeData(color: Colors.black, size: 30),
);
