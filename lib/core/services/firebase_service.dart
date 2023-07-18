import 'dart:io';
import 'dart:math';

import 'package:Quizz/UI/screens/home/home_screen.dart';
import 'package:Quizz/core/models/quiz_question_model.dart';
import 'package:Quizz/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Quizz/core/models/body/login_body.dart';
import 'package:Quizz/core/models/body/reset_password_body.dart';
import 'package:Quizz/core/models/body/signup_body.dart';
import 'package:Quizz/core/models/other_models/onboarding.dart';
import 'package:Quizz/core/models/other_models/user_profile.dart';
import 'package:Quizz/core/models/responses/base_responses/base_response.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'local_storage_service.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  final _localStorageService = locator<LocalStorageService>();

  User? get currentUser => _auth.currentUser;
  String? get currentUserUID => currentUser!.uid;
  DocumentReference get documentReferenceForUser =>
      _firestore.collection('users').doc(currentUserUID);
  DocumentReference get documentReferenceForOnBoarding =>
      _firestore.collection('onBoardingScreen').doc(currentUserUID);
  UserProfile userProfile = UserProfile();
  Onboarding? onboarding;

  Future<void> uploadImageToFirebase(
      bool isAsset, String assetImagePath, File? uploadedMediaImage) async {
    // Get a reference to the Firebase Storage bucket
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();

    final Uint8List image;
    final UploadTask uploadTask;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

    // Get the image file from the assets folder
    if (isAsset) {
      final imageBytes = await rootBundle.load(assetImagePath);
      image = imageBytes.buffer.asUint8List();
      uploadTask = storageRef.child(fileName).putData(image);
    } else {
      uploadTask = storageRef.child(fileName).putFile(uploadedMediaImage!);
    }

    // Create a unique filename for the image

    // Upload the image to Firebase Storage

    // Wait for the upload to complete
    final snapshot = await uploadTask.whenComplete(() {});

    // Get the download URL of the uploaded image
    final downloadURL = await snapshot.ref.getDownloadURL();

    // Save the download URL in Firestore
    await documentReferenceForUser.update({
      'profileImage': downloadURL,
    }).whenComplete(() async {
      await getUserProfile();
      Get.off(const HomeScreen());
    });
  }

  avatarUploadSkipped() {
    documentReferenceForUser.update({
      'profileImage': '',
    }).whenComplete(() async {
      await getUserProfile();
      Get.snackbar('Skipped', 'Image uploading skipped');
    });
    _localStorageService.isAvatarUploaded = true;
  }

  Future<UserProfile> getUserProfile() async {
    await documentReferenceForUser.get().then((value) {
      userProfile = UserProfile.fromMap(value.data());
    });

    return userProfile;
  }

  // Future<Onboarding?> getOnboardingData() async {
  //   await documentReferenceForOnBoarding.get().then((value) {
  //     onboarding = Onboarding.fromMap(value.data());
  //   });
  //   return onboarding;
  // }

  Future<BaseResponse?> updateFcmToken(String deviceId, String token) async {
    return null;
  }

  Future<BaseResponse?> clearFcmToken(String deviceId) async {
    return null;
  }

  // Future<AuthResponse?>
  loginWithEmailAndPassword(LoginBody body) async {
    return null;
  }

  // Future<AuthResponse?>
  createAccount(SignUpBody body) async {
    return null;
  }

  // Future<AuthResponse?>
  resetPassword(ResetPasswordBody body) async {
    return null;
  }

  createQuiz(List<QuizQuestionModel> quizQuestionList, String title,
      String description) async {
    String randomUid = getRandomUid();
    DocumentReference documentReferenceForQuiz =
        _firestore.collection('quizzes').doc(randomUid);
    documentReferenceForQuiz.set({
      'title': title,
      'description': description,
      'quizUID': randomUid,
      'createdBy': currentUserUID,
      'createdAt': DateTime.now(),
    });

    CollectionReference collectionReferenceForQuiz =
        documentReferenceForQuiz.collection('questions');
    quizQuestionList.forEach((element) async {
      await collectionReferenceForQuiz
          .doc(quizQuestionList.indexOf(element).toString())
          .set(
            element.toMap(),
            //       {
            //   'question': element.question,
            //   'correctOption': element.correctOption,
            //   'options': element.options!.map((e) => e.option).toList(),
            // }
          )
          .whenComplete(() {
        quizQuestionList.indexOf(element) == quizQuestionList.length - 1
            ? {
                documentReferenceForUser
                    .collection('quiz')
                    .add({'quizUID': randomUid}).whenComplete(() {
                  Get.offAll(const HomeScreen());
                  Get.snackbar('Successful', 'Quiz successfully created');
                }),
              }
            : null;
      });
    });
  }

  String getRandomUid() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        currentUserUID!.substring(0, 6) +
        (Random().nextInt(9000) + 1000).toString();
  }

  // Future<String> uploadImage(File image, String folderName) async {

  //   return
  // }

  // uploadImageToFirebaseStorage(String filePath) async {
  //   return null;
  // }
}
