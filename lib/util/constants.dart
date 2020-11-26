import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontFamily: 'Itim-Regular',
);

TextStyle titleStyle({double fontSize}) {
  return TextStyle(
    color: Colors.white,
    fontSize: fontSize,
    fontFamily: 'Itim-Regular',
  );
}

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.black.withOpacity(0.15),
  borderRadius: BorderRadius.circular(10.0),
);

final String appName = 'La Bodega del Chino';
final primaryColor = Colors.purple[700];

final themeDataApp = ThemeData(
    primaryColor: primaryColor,
    accentColor: Colors.deepPurpleAccent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor, focusColor: Colors.red));

final kActionMenuStyle = TextStyle(
  color: Colors.black87,
  fontSize: 25,
  fontFamily: 'Itim-Regular',
);
