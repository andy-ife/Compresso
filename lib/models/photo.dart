import 'dart:io';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:compresso/utils/result.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class Photo {
  File? originalFile;
  Future<int?>? _originalSizeKb;
  Future<int?> get originalSizeKb =>
      _originalSizeKb ??= originalFile!.length().then((bytes) => bytes ~/ 1000);

  File? compressedFile;
  Future<int?>? _compressedSizeKb;
  Future<int?> get compressedSizeKb => _compressedSizeKb ??=
      compressedFile!.length().then((bytes) => bytes ~/ 1000);

  Map<String, int>? _resolution;
  Future<Map<String, int>?> get resolution async {
    if (_resolution != null) {
      return _resolution;
    } else {
      try {
        final size = ImageSizeGetter.getSize(FileInput(originalFile!));
        _resolution = {'width': size.width, 'height': size.height};
        return _resolution;
      } catch (e) {
        return {'width': -1, 'height': -1};
      }
    }
  }

  Future<Result<File>> compressToQuality(int quality) async {
    try {
      Directory? tempDir = await getTemporaryDirectory();
      String targetPath =
          '${tempDir.path}/${basename(originalFile!.path).split('.').first}-compressed.jpg';

      var file = await FlutterImageCompress.compressAndGetFile(
          originalFile!.absolute.path, targetPath,
          quality: quality);

      compressedFile = File(file!.path);
      compressedSizeKb; //update the parameter
      return Result.success(compressedFile!);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<File>> compressToSize(int? size) async {
    // size in bytes

    if (size == null) {
      return Result.error(Exception('Invalid size. Please check your input.'));
    }

    if (size > await originalFile!.length()) {
      return Result.error(
          Exception('Enter a value less than the photo\'s size'));
    }

    try {
      Directory? tempDir = await getTemporaryDirectory();
      String targetPath =
          '${tempDir.path}/${basename(originalFile!.path).split('.').first}-compressed.jpg';

      int threshold = 95;

      while (
          (compressedFile == null || await compressedFile!.length() > size) &&
              threshold > 10) {
        var file = await FlutterImageCompress.compressAndGetFile(
            originalFile!.absolute.path, targetPath,
            quality: threshold);

        compressedFile = File(file!.path);
        threshold -= (threshold * 0.1).round(); // decrease threshold by 10%
      }
      return Result.success(compressedFile!);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<bool> selectPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      originalFile = File(image!.path);
      originalSizeKb; // get size
      resolution; // get resolution
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> sharePhoto() async {
    try {
      ShareResult result = await Share.shareXFiles(
          [XFile(compressedFile!.absolute.path)],
          text: 'Share compressed photo');

      if (result.status == ShareResultStatus.success) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }
}
