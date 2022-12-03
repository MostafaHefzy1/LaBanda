class UserModel {
  String? userId, email, name, picture, phonre;

  UserModel({this.userId, this.email, this.name, this.picture, this.phonre});

  UserModel.fromJson(Map<String, dynamic> map) {
    if (map == null) return;

    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    picture = map['picture'];
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'email': email, 'name': name, 'picture': picture};
  }
}
