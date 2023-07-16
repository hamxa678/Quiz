import 'dart:io';

import 'package:Quizz/UI/screens/root/root_screen.dart';
import 'package:Quizz/core/enums/view_state.dart';
import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/core/services/firebase_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/strings.dart';
import '../../../locator.dart';

class SelectAvatarViewModel extends BaseViewModel {
  final firebaseService = locator<FirebaseService>();
  int? selectedAvatarIndex;

  File? profilePicture;
  Uint8List? fileBytes;

  List<String> avatars = [
    '${staticImage}ava1.png',
    '${staticImage}ava2.png',
    '${staticImage}ava3.png',
    '${staticImage}ava4.png',
    '${staticImage}ava5.png',
    '${staticImage}ava6.png',
    '${staticImage}ava7.png',
    '${staticImage}ava8.png',
    '${staticImage}ava9.png',
  ];

  void selectAvatar(int index) {
    selectedAvatarIndex = index;

    notifyListeners();
  }

  uploadAvatar(bool isAsset) async {
    setState(ViewState.busy);

    if (selectedAvatarIndex != null || profilePicture != null) {
      await firebaseService.uploadImageToFirebase(
          isAsset, avatars[selectedAvatarIndex ?? 1], profilePicture);
    }
    setState(ViewState.idle);
  }

  skipAvatar() {
    print('skip avatar'); 
    Get.to(const RootScreen());

    firebaseService.avatarUploadSkipped();
  }

  pickMediaFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      profilePicture = File(result.paths.first!);
      fileBytes = result.files.first.bytes;
      notifyListeners();
    }
  }
}
