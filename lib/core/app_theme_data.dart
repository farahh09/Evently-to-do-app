import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF4F7FF),
      centerTitle: true,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0E3A99),
      onPrimary: Colors.white,
      secondary: Colors.black,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xFFF4F7FF),
      onSurface: Colors.black,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        color: Color(0xFF1C1C1C),
        fontWeight: FontWeight.w600,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 16,
        color: Color(0xFF686868),
        fontWeight: FontWeight.w400,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 18,
        color: Color(0xFF0E3A99),
        fontWeight: FontWeight.w500,
      ),
      displayLarge: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 18,
        color: Color(0xFF686868),
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF000F30),
      centerTitle: true,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF457AED),
      onPrimary: Color(0xFF001440),
      secondary: Colors.white,
      onSecondary: Color(0xFFFFFFFF),
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xFF000F30),
      onSurface: Colors.black,
      primaryContainer: Color(0xFF002D8F),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 18,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 16,
        color: Color(0xFF457AED),
        fontWeight: FontWeight.w400,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 14,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w600,
      ),
      displayLarge: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.poppins(
      fontSize: 18,
      color: Color(0xFFD6D6D6),
      fontWeight: FontWeight.w500,
    ),
    ),
  );
}
