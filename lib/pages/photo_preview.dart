import 'dart:io';

import 'package:compresso/main.dart';
import 'package:compresso/pages/compression_success.dart';
import 'package:compresso/viewmodel/photo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoPreviewPage extends StatefulWidget {
  const PhotoPreviewPage({super.key});

  @override
  State<PhotoPreviewPage> createState() => _PhotoPreviewPageState();
}

class _PhotoPreviewPageState extends State<PhotoPreviewPage> {
  late List<File> photos;
  String? titleText;
  late PageController pageController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    PhotoPreviewArgs args =
        ModalRoute.of(context)!.settings.arguments as PhotoPreviewArgs;
    pageController = PageController(initialPage: args.initialPage);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

    PhotoViewModel viewModel = context.watch<PhotoViewModel>();

    photos = [viewModel.photo.originalFile!, viewModel.photo.compressedFile!];

    if (titleText == null) {
      pageController.initialPage == 0
          ? titleText = localizations.original
          : titleText = localizations.compressed;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(titleText!, style: theme.textTheme.titleSmall),
          backgroundColor: Colors.black,
          iconTheme: theme.iconTheme,
        ),
        body: PhotoViewGallery.builder(
          builder: (context, index) => PhotoViewGalleryPageOptions(
            imageProvider: FileImage(photos[index]),
          ),
          itemCount: photos.length,
          pageController: pageController,
          onPageChanged: (page) {
            setState(() {
              page == 0
                  ? titleText = localizations.original
                  : titleText = localizations.compressed;
            });
          },
        ));
  }
}
