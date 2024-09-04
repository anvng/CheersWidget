class User {
  final int? id;
  final String name;
  final String phoneNumber;
  final String email;
  final DateTime birthdate;

  User(
      {this.id,
      required this.name,
      required this.phoneNumber,
      required this.email,
      required this.birthdate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'birthdate': birthdate.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      birthdate: DateTime.parse(map['birthdate']),
    );
  }

  get profileImage => null;

  bool? get emailVerified => null;
}
