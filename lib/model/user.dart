class UserFileds {
  static final String id = 'id';
  static final String name = 'name';
  static final String email = 'email';
  static final String password = 'password';

  static List<String> getFields() => [id, name, email, password];
}

class User {
  final int? id;
  final String name;
  final String email;
  final String password;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  User copy({
    int? id,
    String? name,
    String? email,
    String? password,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  Map<String, dynamic> toJson() => {
        UserFileds.id: id,
        UserFileds.name: name,
        UserFileds.email: email,
        UserFileds.password: password,
      };
}
