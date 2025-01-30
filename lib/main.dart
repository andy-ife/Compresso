import 'package:compresso/viewmodel/photo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:compresso/pages/home.dart';
import 'package:compresso/pages/choose_compression.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => PhotoViewModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compresso',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.indigo[600]!,
              secondary: Colors.teal[400],
              secondaryFixed: Colors.teal[100],
              surface: const Color(0xFFF3F4FB),
              primaryContainer: Colors.indigo[400],
              surfaceDim: const Color(0xFFE0E0E0)),
          textTheme: const TextTheme(
              titleSmall: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              displaySmall: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
              bodyMedium: TextStyle(fontFamily: 'Open Sans', fontSize: 14.0),
              bodySmall: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              )),
          iconTheme: const IconThemeData(color: Colors.white)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (context) => const HomePage(),
        '/choose_compression': (context) => const ChooseCompressionPage(),
      },
      //home: const HomePage(),
      initialRoute: '/',
    );
  }
}
