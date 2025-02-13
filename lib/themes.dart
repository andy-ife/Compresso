import 'package:flutter/material.dart';

class CompressoTheme {
  // ----------------------------- Light --------------------------------- //
  static ThemeData light = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo[600]!,
          secondary: Colors.teal[400],
          secondaryFixed: Colors.teal[100],
          surface: const Color(0xFFF3F4FB),
          primaryContainer: Colors.indigo[400],
          surfaceDim: const Color(0xFFE0E0E0),
          surfaceContainer: const Color(0xFFBCC3EB)),
      textTheme: const TextTheme(
          titleSmall: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          displayMedium: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(fontFamily: 'Open Sans', fontSize: 14.0),
          bodySmall: TextStyle(fontFamily: 'Open Sans', fontSize: 12.0),
          labelSmall: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          labelMedium: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          )),
      iconTheme: const IconThemeData(color: Colors.white));

  // --------------------------------- Dark -------------------------------- //
  static ThemeData dark = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo[400]!,
          secondary: Colors.teal[400],
          secondaryFixed: Colors.teal[100],
          surface: const Color(0xFF21222C),
          primaryContainer: Colors.indigo[300],
          onPrimaryContainer: Colors.black,
          onSurface: Colors.white,
          surfaceDim: const Color.fromARGB(255, 55, 57, 73),
          surfaceContainer: const Color.fromARGB(255, 52, 54, 70)),
      textTheme: const TextTheme(
          titleSmall: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          displayMedium: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          displaySmall: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          bodyLarge: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          bodyMedium: TextStyle(
              fontFamily: 'Open Sans', fontSize: 14.0, color: Colors.white),
          bodySmall: TextStyle(
              fontFamily: 'Open Sans', fontSize: 12.0, color: Colors.white),
          labelSmall: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 184, 184, 184),
          ),
          labelMedium: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 184, 184, 184),
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          )),
      iconTheme: const IconThemeData(color: Colors.white));
}
