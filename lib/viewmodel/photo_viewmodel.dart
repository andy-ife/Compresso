import 'package:compresso/models/photo.dart';
import 'package:compresso/utils/result.dart';
import 'package:flutter/material.dart';

class PhotoViewModel extends ChangeNotifier {
  Photo _photo = Photo();

  Result<Photo?>? _uiState;
  Result<Photo?>? get uiState => _uiState;

  Future<void> selectPhoto() async {
    _photo = Photo();
    var result = await _photo.selectPhoto();
    if (result) {
      _uiState = Result.success(_photo);
      notifyListeners();
    } else {
      _uiState = Result.error(Exception('Couldn\'t select photo'));
      notifyListeners();
    }
  }

  void compress(int quality) async {
    _uiState = Result.loading('Compressing photo...');
    notifyListeners();

    var result = await _photo.compress(quality);
    if (result is Success) {
      _uiState = Result.success(_photo);
      notifyListeners();
    } else if (result is Error) {
      _uiState = Result.error((result as Error).error);
      notifyListeners();
    }
  }

  void refresh() {
    _uiState = null;
  }
}
