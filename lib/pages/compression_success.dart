import 'package:compresso/components/compression_success_photo.dart';
import 'package:compresso/components/icon_with_label.dart';
import 'package:compresso/components/photo_progress_bar.dart';
import 'package:compresso/viewmodel/photo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CompressionSuccessPage extends StatefulWidget {
  const CompressionSuccessPage({super.key});

  @override
  State<CompressionSuccessPage> createState() => _CompressionSuccessPageState();
}

class _CompressionSuccessPageState extends State<CompressionSuccessPage> {
  int? _originalSize;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

    PhotoViewModel viewModel = context.watch<PhotoViewModel>();

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
          color: theme.colorScheme.primaryContainer,
          height: 66.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconWithLabel(
                    const Icon(Icons.home_outlined), localizations.home, () {}),
                IconWithLabel(const Icon(Icons.share_outlined),
                    localizations.share, () {}),
                IconWithLabel(
                    const Icon(Icons.save_outlined), localizations.save, () {})
              ],
            ),
          )),
      body: SafeArea(
        child: Align(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/check_mark.png',
                      height: 32.0,
                      width: 32.0,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      localizations.success,
                      style: theme.textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 340.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    controller: _scrollController,
                    children: [
                      CompressionSuccessPhoto(viewModel.photo.originalFile!,
                          localizations.original),
                      const SizedBox(
                        width: 24.0,
                      ),
                      CompressionSuccessPhoto(viewModel.photo.compressedFile!,
                          localizations.compressed)
                    ],
                  ),
                ),
                Column(
                  children: [
                    FutureBuilder(
                      future: viewModel.photo.originalSizeKb,
                      builder: (context, snapshot) {
                        _originalSize = snapshot.data;
                        return PhotoProgressBar(
                            localizations.original, '${snapshot.data} KB', 1.0);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    FutureBuilder(
                      future: viewModel.photo.compressedSizeKb,
                      builder: (context, snapshot) {
                        double prog = snapshot.data!.toDouble() /
                            _originalSize!.toDouble();
                        return PhotoProgressBar(localizations.compressed,
                            '${snapshot.data} KB', prog);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
