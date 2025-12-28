import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF2FEFF),
      centerTitle: true,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF5669FF),
      onPrimary: Colors.black,
      secondary: Colors.black,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xFFF2FEFF),
      onSurface: Colors.black,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        color: Color(0xFF5669FF),
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 20,
        color: Color(0xFF5669FF),
        fontWeight: FontWeight.w500,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF101127),
      centerTitle: true,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF5669FF),
      onPrimary: Colors.black,
      secondary: Colors.white,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xFF101127),
      onSurface: Colors.black,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        color: Color(0xFF5669FF),
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 20,
        color: Color(0xFF5669FF),
        fontWeight: FontWeight.w500,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
