import 'package:compresso/utils/result.dart';
import 'package:compresso/viewmodel/photo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<PhotoViewModel>();

    ThemeData theme = Theme.of(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.appName,
          style: theme.textTheme.titleSmall,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_rounded,
                color: theme.colorScheme.onPrimary),
            onPressed: () {},
          )
        ],
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
      ),
      body: Align(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.photo_library_outlined,
                color: theme.colorScheme.secondaryFixed, size: 100.0),
            TextButton(
                onPressed: () async {
                  await viewModel.selectPhoto();
                  if (viewModel.uiState is Success) {
                    Navigator.pushNamed(context, '/choose_compression');
                  }
                },
                style: ButtonStyle(
                  textStyle:
                      WidgetStatePropertyAll(theme.textTheme.displaySmall),
                  backgroundColor: WidgetStatePropertyAll(
                      theme.colorScheme.primaryContainer),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white),
                  elevation: const WidgetStatePropertyAll(2.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 32.0),
                  child: Text(localizations.choosePhoto),
                ))
          ],
        ),
      ),
    );
  }
}
