import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1d212b),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          headline5: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
  );
}
