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
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: theme.colorScheme.surfaceDim)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: theme.colorScheme.surfaceDim,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.file(
                      viewModel.photo.originalFile!,
                      semanticLabel: localizations.photoToCompress,
                      width: 160.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PhotoInfoCard(
                            title: localizations.selected, info: "1 photo"),
                        const SizedBox(height: 8.0),
                        FutureBuilder(
                            future: viewModel.photo.originalSizeKb,
                            builder: (context, snapshot) {
                              return PhotoInfoCard(
                                  title: localizations.size,
                                  info: '${snapshot.data} KB');
                            }),
                        const SizedBox(height: 8.0),
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
          ],
        ),
      ),
    );
  }
}
