import 'package:flutter/material.dart';

class AppTheme {

  final Color electusColor;

  AppTheme ({
    this.electusColor = Colors.orangeAccent
  });

  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: electusColor
  );
}