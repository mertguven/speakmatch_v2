// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
        primaryColor: Colors.white,
        brightness: Brightness.light,
        colorScheme: ColorScheme.light().copyWith(
          primary: Color(0xff1F2A5D),
          secondary: Color(0xffD64565),
        ));
  }
}
