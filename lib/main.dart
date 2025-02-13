import 'package:compresso/pages/compression_success.dart';
import 'package:compresso/pages/photo_preview.dart';
import 'package:compresso/themes.dart';
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
      theme: CompressoTheme.light,
      darkTheme: CompressoTheme.dark,
      themeMode: ThemeMode.system,
      themeAnimationStyle: AnimationStyle.noAnimation,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (context) => const HomePage(),
        '/choose_compression': (context) => const ChooseCompressionPage(),
        '/compression_success': (context) => const CompressionSuccessPage(),
        '/photo_preview': (context) => const PhotoPreviewPage()
      },
      //home: const HomePage(),
      initialRoute: '/',
    );
  }
}
