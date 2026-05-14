class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'created_at': createdAt,
    };
  }
}
