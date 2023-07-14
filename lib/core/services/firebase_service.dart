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
