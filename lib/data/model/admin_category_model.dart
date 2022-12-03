class AdminCategoryModel {
  String? image;

  String? title;

  String? description;

  String? price;

  String? numberCategory;

  // String ? product_id ;

  AdminCategoryModel({
    this.image,
    this.title,
    this.description,
    this.numberCategory,
    this.price,
    // this.product_id
  });

  //named constructor
  AdminCategoryModel.fromJson(Map<String, dynamic> map) {
    image = map['image'];
    title = map['title'];
    description = map['description'];
    price = map['price'];
    numberCategory = map['numberCategory'];
    // product_id = map['product_id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'price': price,
      'description': description,
      'numberCategory': numberCategory,
      // 'product_id': product_id,
    };
  }
}
