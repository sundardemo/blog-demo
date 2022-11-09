class AdModel {
  String? sId;
  String? title;
  String? description;
  int? price;
  List<String>? images;
  String? authorName;
  String? userId;
  String? mobile;
  String? createdAt;

  AdModel(
      {this.sId,
      this.title,
      this.description,
      this.price,
      this.images,
      this.authorName,
      this.userId,
      this.mobile,
      this.createdAt});

  AdModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    price = json['price'] ?? '';
    images =
        List<String>.from(json['images'] ?? ['http://placehold.it/100x100']);
    authorName = json['authorName'] ?? '';
    userId = json['userId'] ?? '';
    mobile = json['mobile'] ?? '';
    createdAt = json['createdAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['images'] = images;
    data['authorName'] = authorName;
    data['userId'] = userId;
    data['mobile'] = mobile;
    data['createdAt'] = createdAt;
    return data;
  }
}
