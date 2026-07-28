import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),

    headlineLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),

    headlineMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

    titleLarge: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),

    bodyLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),

    bodyMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),

    titleSmall: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),

    labelLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
  );
}
