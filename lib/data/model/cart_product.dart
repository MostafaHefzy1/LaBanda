class CartModel {
  String? image, price, name;

  int? quatity;

  CartModel({
    this.price,
    this.name,
    this.image,
    this.quatity,
  });

  CartModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    image = map['image'];
    price = map['price'];
    quatity = map['quatity'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quatity': quatity,
    };
  }
}
