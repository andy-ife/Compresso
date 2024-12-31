import 'package:compresso/viewmodel/photo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:compresso/components/photo_info_card.dart';

class ChooseCompressionPage extends StatelessWidget {
  const ChooseCompressionPage({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<PhotoViewModel>();

    ThemeData theme = Theme.of(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.chooseCompression,
          style: theme.textTheme.titleSmall,
        ),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
        iconTheme: theme.iconTheme,
      ),
      body: Align(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.file(
                viewModel.photo.originalFile!,
                semanticLabel: localizations.photoToCompress,
                width: 400.0,
                height: 300.0,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PhotoInfoCard(title: localizations.selected, info: "1 photo"),
                  FutureBuilder(
                      future: viewModel.photo.originalSizeKb,
                      builder: (context, snapshot) {
                        return PhotoInfoCard(
                            title: localizations.size,
                            info: '${snapshot.data} KB');
                      }),
                  FutureBuilder(
                      future: viewModel.photo.resolution,
                      builder: (context, snapshot) {
                        return PhotoInfoCard(
                            title: localizations.resolution,
                            info:
                                '${snapshot.data?['width']} x ${snapshot.data?['height']}');
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
