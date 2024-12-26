import 'package:flutter/material.dart';
import 'package:compresso/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compresso',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo[600]!),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16.0,
            fontWeight: FontWeight.w600
          ),
          
          displaySmall: TextStyle(
            fontFamily: 'Open Sans'
          ),

          bodyMedium: TextStyle(
            fontFamily: 'Open Sans',
          ),

          bodySmall: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 12.0,
          )
        )
      ),
      
      home: const HomePage(),
    );
  }
}
          
