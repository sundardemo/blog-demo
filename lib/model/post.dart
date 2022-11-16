class PostModel {
  String? id;
  String? title;
  String? description;
  String? date;

  PostModel({this.id, this.title, this.description, this.date});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id ?? '';
    data['title'] = title ?? '';
    data['description'] = description ?? '';
    data['date'] = date ?? '';
    return data;
  }
}
