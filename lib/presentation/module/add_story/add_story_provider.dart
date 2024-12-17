import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layar_cerita_app/utils/image_utils.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';

import '../../../data/repository/story_repository.dart';
import '../../../data/source/network/request/add_story_body.dart';

class AddStoryProvider extends ChangeNotifier {
  XFile? imageFile;
  String imagePath = '';
  String description = '';
  bool isValid = false;

  bool isShouldRefreshPreviousPage = false;

  final StoryRepository _storyRepository;

  UIState _addStoryState = UIState.initial();
  UIState get addStoryState => _addStoryState;

  AddStoryProvider({required StoryRepository storyRepository})
      : _storyRepository = storyRepository;

  Future<void> pickImageFromGallery({
    required Function(String message) onFailed,
    required Function() onSuccess,
  }) async {
    debugPrint("pickImageFromGallery");
    final ImagePicker picker = ImagePicker();

    if (defaultTargetPlatform != TargetPlatform.android) {
      onFailed.call("Fitur belum disupport di platform ini");
      return;
    }

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      onSetImage(pickedFile);
      _checkIsValid();
      onSuccess.call();
    } else {
      onFailed.call("Pilih gambar terlebih dahulu");
    }
  }

  Future<void> picImageFromCamera({
    required Null Function(dynamic message) onFailed,
    required Null Function() onSuccess,
  }) async {
    debugPrint("pickImageFromCamera");
    final ImagePicker picker = ImagePicker();

    if (defaultTargetPlatform != TargetPlatform.android) {
      onFailed.call("Fitur belum disupport di platform ini");
      return;
    }

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      onSetImage(pickedFile);
      _checkIsValid();
      onSuccess.call();
    } else {
      onFailed.call("Pilih gambar terlebih dahulu");
    }
  }

  void onSetImage(XFile result) {
    imageFile = result;
    imagePath = result.path;
    notifyListeners();
  }

  void onDescriptionChanged(String value) {
    description = value;
    notifyListeners();
    _checkIsValid();
  }

  void _checkIsValid() {
    isValid =
        imageFile != null && imagePath.isNotEmpty && description.isNotEmpty;
    notifyListeners();
  }

  Future<void> uploadStory({
    required Function() onSuccess,
  }) async {
    _addStoryState = UIState.loading(message: "Mengupload cerita...");
    notifyListeners();
    try {
      final filename = imageFile?.name ?? "";
      final bytes = await imageFile?.readAsBytes();
      final addStorybody = AddStoryBody(description: description);

      if (bytes != null) {
        final compressedBytes = await ImageUtils.compressImage(bytes);
        await _storyRepository.addStory(
          bytes: compressedBytes,
          filename: filename,
          addStorybody: addStorybody,
        );

        _addStoryState = UIState.success();
        isShouldRefreshPreviousPage = true;
        imagePath = '';
        imageFile = null;
        notifyListeners();
        onSuccess.call();
      } else {
        _addStoryState = UIState.error("Pilih gambar terlebih dahulu");
        notifyListeners();
      }
    } catch (e) {
      _addStoryState = UIState.error(e.toString());
      notifyListeners();
    }
  }

  resetState() {
    _addStoryState = UIState.initial();
    notifyListeners();
  }
}
