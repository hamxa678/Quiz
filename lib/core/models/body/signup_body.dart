import 'dart:io';
// import 'package:dio/dio.dart' as dio;

class SignUpBody {
  String? name;
  String? username;
  String? email;
  String? password;

  File? image;

  SignUpBody({
    this.email,
    this.password,
    this.username,
    this.name,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'username': username,
      // 'image':
      //     image != null ? await dio.MultipartFile.fromFile(image!.path) : null,
    };
  }
}
