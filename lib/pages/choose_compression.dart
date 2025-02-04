import 'package:compresso/components/compression_option_card.dart';
import 'package:compresso/components/custom_compression_dialog.dart';
import 'package:compresso/components/loading_dialog.dart';
import 'package:compresso/icons/compresso_icons.dart';
import 'package:compresso/utils/result.dart';
import 'package:compresso/viewmodel/photo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:compresso/components/photo_info_card.dart';

const int CARD_SMALL_SIZE = 0;
const int CARD_MEDIUM_SIZE = 1;
const int CARD_LARGE_SIZE = 2;
const int CARD_CUSTOM_SIZE = 3;

class ChooseCompressionPage extends StatefulWidget {
  const ChooseCompressionPage({super.key});

  @override
  State<ChooseCompressionPage> createState() => _ChooseCompressionPageState();
}

class _ChooseCompressionPageState extends State<ChooseCompressionPage> {
  int selected = CARD_MEDIUM_SIZE;
  int quality = 70; // medium photo quality
  String unit = 'KB';

  late TextEditingController controller;

  late PhotoViewModel viewModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<PhotoViewModel>(context, listen: false);
    viewModel.addListener(mlistener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    viewModel.removeListener(mlistener);
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100.0),
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
                    height: 200.0,
                    //color: theme.colorScheme.surfaceDim,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.file(
                      viewModel.photo.originalFile!,
                      semanticLabel: localizations.photoToCompress,
                      width: 160.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PhotoInfoCard(
                              title: localizations.selected, info: "1 photo"),
                          const SizedBox(height: 12.0),
                          FutureBuilder(
                              future: viewModel.photo.originalSizeKb,
                              builder: (context, snapshot) {
                                return PhotoInfoCard(
                                    title: localizations.size,
                                    info: '${snapshot.data} KB');
                              }),
                          const SizedBox(height: 12.0),
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
                    ),
                  )
                ],
              ),
            ),
            CompressionOptionCard(
                CARD_SMALL_SIZE,
                const Icon(CompressoIcons.compress_arrows_alt),
                localizations.titleSmallSize,
                localizations.descSmallSize,
                (selected == CARD_SMALL_SIZE), () {
              setState(() {
                selected = CARD_SMALL_SIZE;
                quality = 45; // compress photo to low quality
              });
            }),
            CompressionOptionCard(
                CARD_MEDIUM_SIZE,
                const Icon(CompressoIcons.compress_alt),
                localizations.titleMediumSize,
                localizations.descMediumSize,
                (selected == CARD_MEDIUM_SIZE), () {
              setState(() {
                selected = CARD_MEDIUM_SIZE;
                quality = 70; // compress to medium quality
              });
            }),
            CompressionOptionCard(
                CARD_LARGE_SIZE,
                const Icon(CompressoIcons.compress),
                localizations.titleLargeSize,
                localizations.descLargeSize,
                (selected == CARD_LARGE_SIZE), () {
              setState(() {
                selected = CARD_LARGE_SIZE;
                quality = 90; // compress but retain great quality
              });
            }),
            CompressionOptionCard(
                CARD_CUSTOM_SIZE,
                const Icon(Icons.edit_rounded),
                localizations.titleCustomSize,
                localizations.descCustomSize,
                (selected == CARD_CUSTOM_SIZE), () {
              setState(() {
                selected = CARD_CUSTOM_SIZE;
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomCompressionSizeDialog(controller, (newUnit) {
                        unit = newUnit;
                      }, () async {
                        int? targetSize = int.tryParse(controller.text);
                        if (unit == 'KB') {
                          targetSize =
                              targetSize != null ? targetSize * 1000 : null;
                        } else if (unit == 'MB') {
                          targetSize =
                              targetSize != null ? targetSize * 1000000 : null;
                        }

                        Navigator.of(context).pop();

                        await viewModel.compressToSize(targetSize);

                        if (viewModel.uiState is Success) {
                          if (isLoading) {
                            Navigator.of(context).pop();
                            isLoading = false;
                          }
                          Navigator.pushReplacementNamed(
                              context, '/compression_success');
                        }
                      });
                    });
              });
            })
          ],
        ),
      ),
      bottomSheet: BottomSheet(
          onClosing: () {},
          shape: const RoundedRectangleBorder(),
          enableDrag: false,
          builder: (context) {
            return GestureDetector(
              onTap: () async {
                if (selected != CARD_CUSTOM_SIZE) {
                  await viewModel.compressToQuality(quality);
                  if (viewModel.uiState is Success) {
                    Navigator.pushNamed(context, '/compression_success');
                  }
                }
              },
              child: Container(
                  height: 60.0,
                  color: theme.colorScheme.primaryContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        localizations.compress,
                        style: theme.textTheme.titleSmall,
                      ),
                      const Icon(Icons.arrow_right_alt_rounded),
                    ],
                  )),
            );
          }),
    );
  }

  void mlistener() async {
    final state = viewModel.uiState;
    if (state is Error) {
      if (isLoading) {
        Navigator.of(context).pop();
        isLoading = false;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text((state as Error).error.toString())),
      );
    }

    if (state is Loading) {
      isLoading = true;
      showDialog(
          context: context,
          builder: (context) {
            return const LoadingDialog();
          });
    }
  }
}
