import 'dart:convert';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map){
    return User(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
