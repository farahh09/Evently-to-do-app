class UserModel {
  String email;
  String name;
  String id;

  UserModel({required this.email, required this.name, this.id = ''});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
    email: json['email'],
    name: json['name'],
    id: json['id'],
  );

  Map<String, Object> toJson() {
    return {
      'email': email,
      'name': name,
      'id': id,
    };
  }
}
