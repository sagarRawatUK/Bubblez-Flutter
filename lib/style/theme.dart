import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData UiThemeData() {
  return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 15,
          color: whiteColor,
        ),
        bodyText2: TextStyle(
          fontSize: 20,
          color: whiteColor,
        ),
        subtitle1: TextStyle(
          fontSize: 13,
          color: greyColor,
        ),
      ),
      accentColor: blueColor,
      fontFamily: 'Poppins',
      canvasColor: Colors.transparent);
}
