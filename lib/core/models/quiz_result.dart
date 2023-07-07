class QuizResultModel {
  String? image;
  String? name;
  int? scorePercent;

  QuizResultModel({this.image, this.name, this.scorePercent});

  QuizResultModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    scorePercent = json['scorePercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['scorePercent'] = scorePercent;
    return data;
  }
}
