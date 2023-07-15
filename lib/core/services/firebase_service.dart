import 'dart:io';

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

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  User? get currentUser => _auth.currentUser;
  String? get currentUserUID => currentUser!.uid;
  DocumentReference get documentReferenceForUser =>
      _firestore.collection('users').doc(currentUserUID);
  DocumentReference get documentReferenceForOnBoarding =>
      _firestore.collection('onBoardingScreen').doc(currentUserUID);
  UserProfile userProfile = UserProfile();
  Onboarding? onboarding;

  Future<void> uploadImageToFirebase(String assetImagePath) async {
    // Get a reference to the Firebase Storage bucket
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();

    // Get the image file from the assets folder
    final imageBytes = await rootBundle.load(assetImagePath);
    final imageData = imageBytes.buffer.asUint8List();

    // Create a unique filename for the image
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

    // Upload the image to Firebase Storage
    final uploadTask = storageRef.child(fileName).putData(imageData);

    // Wait for the upload to complete
    final snapshot = await uploadTask.whenComplete(() {});

    // Get the download URL of the uploaded image
    final downloadURL = await snapshot.ref.getDownloadURL();

    // Save the download URL in Firestore
    await documentReferenceForUser.update({
      'profileImage': downloadURL,
    }).whenComplete(
      () => Get.snackbar('Success', 'Image uploaded successfully'),
    );
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

  // Future<String> uploadImage(File image, String folderName) async {

  //   return
  // }

  // uploadImageToFirebaseStorage(String filePath) async {
  //   return null;
  // }
}
