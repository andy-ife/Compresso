import 'package:compresso/components/compression_success_photo.dart';
import 'package:compresso/components/icon_with_label.dart';
import 'package:compresso/components/photo_progress_bar.dart';
import 'package:compresso/viewmodel/photo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:compresso/utils/result.dart';

class CompressionSuccessPage extends StatefulWidget {
  const CompressionSuccessPage({super.key});

  @override
  State<CompressionSuccessPage> createState() => _CompressionSuccessPageState();
}

class _CompressionSuccessPageState extends State<CompressionSuccessPage> {
  final _scrollController = ScrollController();

  late PhotoViewModel viewModel;
  bool hasSavedPhoto = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<PhotoViewModel>(context, listen: false);
    viewModel.addListener(cslistener);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.removeListener(cslistener);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

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
                    const Icon(Icons.home_outlined), localizations.home, () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }),
                IconWithLabel(
                    const Icon(Icons.share_outlined), localizations.share,
                    () async {
                  await viewModel.sharePhoto();
                }),
                IconWithLabel(
                    const Icon(Icons.save_outlined), localizations.save,
                    () async {
                  hasSavedPhoto = true;
                  await viewModel.savePhoto();
                })
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
                      CompressionSuccessPhoto(
                          viewModel.photo.originalFile!, localizations.original,
                          () {
                        Navigator.pushNamed(context, '/photo_preview',
                            arguments: PhotoPreviewArgs(0));
                      }),
                      const SizedBox(
                        width: 24.0,
                      ),
                      CompressionSuccessPhoto(viewModel.photo.compressedFile!,
                          localizations.compressed, () {
                        Navigator.pushNamed(context, '/photo_preview',
                            arguments: PhotoPreviewArgs(1));
                      })
                    ],
                  ),
                ),
                FutureBuilder(
                    future: viewModel.photo.originalSizeKb,
                    builder: (context, originalSnapshot) {
                      return FutureBuilder(
                          future: viewModel.photo.compressedSizeKb,
                          builder: (context, compressedSnapshot) {
                            return Column(
                              children: [
                                PhotoProgressBar(localizations.original,
                                    '${originalSnapshot.data} KB', 1.0),
                                const SizedBox(height: 16.0),
                                PhotoProgressBar(
                                    localizations.compressed,
                                    '${compressedSnapshot.data} KB',
                                    compressedSnapshot.data!.toDouble() /
                                        originalSnapshot.data!.toDouble())
                              ],
                            );
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void cslistener() async {
    final state = viewModel.uiState;
    AppLocalizations loc = AppLocalizations.of(context)!;

    if (state is Error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text((state as Error).error.toString())),
      );
    }

    if (state is Success && hasSavedPhoto == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loc.photoSaved)));
    }

    if (state is Loading) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loc.savingPhoto)));
    }
  }
}

class PhotoPreviewArgs {
  final int initialPage;
  PhotoPreviewArgs(this.initialPage);
}
