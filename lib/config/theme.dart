import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    textTheme: GoogleFonts.poppinsTextTheme(),
    // Add more theme configurations
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    // Add more theme configurations
  );
}
