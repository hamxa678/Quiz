import 'package:Quizz/core/enums/view_state.dart';
import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/core/services/firebase_service.dart';

import '../../../core/constants/strings.dart';
import '../../../locator.dart';

class SelectAvatarViewModel extends BaseViewModel {
  final firebaseService = locator<FirebaseService>();
  int? selectedAvatarIndex;

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

  uploadAvatar() async {
    setState(ViewState.busy);

    if (selectedAvatarIndex != null) {
      await firebaseService
          .uploadImageToFirebase(avatars[selectedAvatarIndex!]);
    }

    setState(ViewState.idle);
  }
}
