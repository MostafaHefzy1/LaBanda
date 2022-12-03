class CategoryModel {
  String? title, image;

  CategoryModel({this.title, this.image});

  CategoryModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }

    title = map['title'];
    image = map['image'];
  }

  toJson() {
    return {'title': title, 'image': image};
  }
}
