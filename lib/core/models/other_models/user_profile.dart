// import 'package:dio/dio.dart' as dio;

class UserProfile {
  //   String? name;
  // String? username;
  // String? email;
  // String? password;

  // File? image;

  String? userName;
  String? name;
  String? email;
  String? password;
  // String? fcmToken;
  // String? phone;
  String? profileImageUrl;
  // String? gender;
  // String? location;
  // String? dob;

  UserProfile({
    this.userName,
    this.name,
    this.email,
    this.password,
    this.profileImageUrl
  });

  factory UserProfile.fromMap(map) {
    return UserProfile(
      userName: map['username'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      // fcmToken: map['fcm_token'],
      // phone: map['phone'],
      profileImageUrl: map['profileImage'],
      // gender: map['gender'],
      // location: map['location'],
      // dob: map['dob'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'username': userName,
      'name': name,
      'email': email,
      'password': password,
      // 'phone': phone,
      // 'gender': gender,
      // 'location': location
    };
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    // data['phone'] = phone;
    // data['image'] =
    //     imageUrl != null ? await dio.MultipartFile.fromFile(imageUrl!) : null;
    // data['gender'] = gender;
    // data['location'] = location;
    return data;
  }

  deepCopy() {
    return UserProfile(
        userName: userName,
        name: name,
        email: email,
        password: password,
        // fcmToken: fcmToken,
        // phone: phone,
        // imageUrl: imageUrl,
        // gender: gender,
        // location: location
        );
  }
}
