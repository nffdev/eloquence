import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  
  // Colors
  static const Color darkBackground = Colors.black;
  static const Color lightBackground = Colors.white;
  static const Color accentColor = Color(0xFF8E8E93);
  static const Color lightAccentColor = Color(0xFF636366);
  
  // Dark Theme
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        letterSpacing: 1.0,
      ),
      bodyLarge: GoogleFonts.lato(
        fontSize: 18,
        color: Colors.white70,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 16,
        color: Colors.white60,
        letterSpacing: 0.5,
        height: 1.5,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkBackground,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return Colors.white70;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return accentColor;
          }
          return Colors.grey.shade800;
        },
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.white24,
      thickness: 0.5,
    ),
  );
  
  // Light Theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: lightBackground,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: 1.2,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        letterSpacing: 1.0,
      ),
      bodyLarge: GoogleFonts.lato(
        fontSize: 18,
        color: Colors.black87,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 16,
        color: Colors.black54,
        letterSpacing: 0.5,
        height: 1.5,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightBackground,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
    ),
    iconTheme: const IconThemeData(color: Colors.black54),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.black;
          }
          return Colors.black45;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return lightAccentColor;
          }
          return Colors.grey.shade300;
        },
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.black12,
      thickness: 0.5,
    ),
  );
}
