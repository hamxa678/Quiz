import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  String? title;
  String? description;
  String? quizUID;
  String? createdBy;
  Timestamp? createdAt;
  String? authorName;

  QuizModel(
      {this.title,
      this.description,
      this.quizUID,
      this.createdBy,
      this.createdAt,
      this.authorName});

  // QuizModel.fromMap(Map<String, dynamic> map) {
  //   title = 'title';
  //   description = 'description';
  //   quizUID = 'quizUID';
  //   createdBy = 'createdBy';
  //   createdAt = 'createdAt';
  //   authorName = 'authorName';
  // }

  factory QuizModel.fromMap(map) {
    return QuizModel(
      title: map['title'],
      description: map['description'],
      quizUID: map['quizUID'],
      createdBy: map['createdBy'],
      createdAt: map['createdAt'],
      authorName: map['authorName'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['quizUID'] = quizUID;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['authorName'] = authorName;
    return data;
  }
}
