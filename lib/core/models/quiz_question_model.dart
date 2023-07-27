class QuizQuestionModel {
  String? question;
  List<dynamic>? options;
  int? correctOption;
  int? selectedOption;

  QuizQuestionModel(
      {this.question, this.options, this.correctOption, this.selectedOption});

  factory QuizQuestionModel.fromMap(Map<String, dynamic> map) {
    return QuizQuestionModel(
      question: map['question'],
      options: map['options'],
      correctOption: map['correctOption'],
    );
  }

  QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    correctOption = json['correctOption'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['correctOption'] = correctOption;
    return data;
  }
}

class Options {
  String? option;

  Options({this.option});

  Options.fromJson(Map<String, dynamic> json) {
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option'] = option;
    return data;
  }
}
