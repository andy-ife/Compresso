import 'dart:io';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:compresso/utils/result.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Photo {
  final File originalFile;
  Future<int?>? _originalSizeKb;
  Future<int?> get originalSizeKb =>
      _originalSizeKb ??= originalFile.length().then((bytes) => bytes ~/ 1000);

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
        final size = ImageSizeGetter.getSize(FileInput(originalFile));
        _resolution = {'width': size.width, 'height': size.height};
        return _resolution;
      } catch (e) {
        return {'width': -1, 'height': -1};
      }
    }
  }

  Photo(this.originalFile);

  Future<Result<File>> compress(int quality) async {
    try {
      Directory? cacheDir = await getApplicationCacheDirectory();
      String targetPath =
          '${cacheDir.path}/${basename(originalFile.path)}-compressed.jpg';

      var file = await FlutterImageCompress.compressAndGetFile(
          originalFile.absolute.path, targetPath,
          quality: quality);

      compressedFile = File(file!.path);
      compressedSizeKb; //update the parameter
      return Result.success(compressedFile!);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
