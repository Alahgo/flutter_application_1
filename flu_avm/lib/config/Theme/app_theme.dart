import 'package:flutter/material.dart';

class AppTheme {

  final Color electusColor;
  final bool tenebrisModusEst;

  AppTheme ({
    this.electusColor = Colors.orangeAccent,
    this.tenebrisModusEst = false
  });

  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: electusColor,
    brightness: tenebrisModusEst ? Brightness.dark: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: tenebrisModusEst ?electusColor :electusColor.withAlpha(80),
      centerTitle: false
    )
  );
}