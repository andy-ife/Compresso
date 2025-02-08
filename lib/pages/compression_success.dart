import 'package:compresso/components/compression_success_photo.dart';
import 'package:compresso/viewmodel/photo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CompressionSuccessPage extends StatelessWidget {
  const CompressionSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

    PhotoViewModel viewModel = context.watch<PhotoViewModel>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Align(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/check_mark.png',
                height: 48.0,
                width: 48.0,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                localizations.success,
                style: theme.textTheme.displayMedium,
              ),
              SizedBox(
                height: 220.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CompressionSuccessPhoto(viewModel.photo.originalFile!,
                        localizations.originalImage),
                    CompressionSuccessPhoto(viewModel.photo.compressedFile!,
                        localizations.compressedImage)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
