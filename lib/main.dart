import 'package:compresso/pages/compression_success.dart';
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
          iconTheme: const IconThemeData(color: Colors.white)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (context) => const HomePage(),
        '/choose_compression': (context) => const ChooseCompressionPage(),
        '/compression_success': (context) => CompressionSuccessPage()
      },
      //home: const HomePage(),
      initialRoute: '/',
    );
  }
}
