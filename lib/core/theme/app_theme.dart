// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        dividerColor: Colors.transparent,
        fontFamily: GoogleFonts.montserrat().fontFamily,
        brightness: Brightness.light,
        primaryColor: Colors.white,
        colorScheme: ColorScheme.light().copyWith(
          primary: Color(0xff1F2A5D),
          secondary: Color(0xffD64565),
        ));
    /*return ThemeData.light().copyWith(textTheme: TextTheme(),
        primaryColor: Colors.white,
        brightness: Brightness.light,
        colorScheme: ColorScheme.light().copyWith(
          primary: Color(0xff1F2A5D),
          secondary: Color(0xffD64565),
        ));*/
  }
}
