import 'cart_product.dart';

class OrderModel {
  String? name, phone, address, documentId;
  double? latitude, longitude, price;

  OrderModel({
    this.name,
    this.phone,
    this.address,
    this.longitude,
    this.latitude,
    this.documentId,
    this.price,
  });

  OrderModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    phone = map['phone'];
    address = map['address'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    documentId = map['documentId'];
    price = map['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'documentId': documentId,
      'price': price,
    };
  }
}
