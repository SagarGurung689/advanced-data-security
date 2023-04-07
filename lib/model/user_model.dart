class Users {
  String? id;
  String? name;
String? email;
String? image;

  Users({
    this.id,
    this.name,
    this.email,
    this.image,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['uid'].toString();
    name = json['name'];
    email = json['email'];
    image = json['image'];
    ;
  }

  Map<String, dynamic> userToMap() {
    Map<String, dynamic> data = {};

    data['name'] = name;

    data['email'] = email;

    data['image'] = image;

    return data;
  }
}
