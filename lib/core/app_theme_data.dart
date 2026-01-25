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
      error: Color(0xFFFF3232),
      onError: Colors.white,
      surface: Color(0xFFF4F7FF),
      onSurface: Color(0xFF1C1C1C),
      outline: Color(0xFFF0F0F0),
      inverseSurface: Colors.white,
      onInverseSurface: Color(0xFF1C1C1C),

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
      headlineLarge: GoogleFonts.poppins(
        fontSize: 24,
        color: Color(0xFF0E3A99),
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 14,
        color: Color(0xFF686868),
        fontWeight: FontWeight.w400,
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
      surface: Color(0xFF000F30),
      onSurface: Colors.white,
      outline: Color(0xFF002D8F),
      error: Color(0xFFFF3232),
      onError: Colors.white,
      inverseSurface: Color(0xFF1C1C1C),
      onInverseSurface: Colors.white,

    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w600,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 16,
        color: Color(0xFF457AED),
        fontWeight: FontWeight.w400,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 18,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
      ),
      displayLarge: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 14,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 18,
        color: Color(0xFFD6D6D6),
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
