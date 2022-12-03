class ProductModel {
  String? description, image, numberCategory, price, title;

  ProductModel({
    this.description,
    this.price,
    this.numberCategory,
    this.title,
    this.image,
  });

  ProductModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    title = map['title'];
    image = map['image'];
    description = map['description'];
    price = map['price'];
    numberCategory = map['numberCategory'];
  }

  toJson() {
    return {
      'title': title,
      'image': image,
      'description': description,
      'price': price,
      'numberCategory': numberCategory,
    };
  }
}
