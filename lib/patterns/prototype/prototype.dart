import 'package:flutter/material.dart';

@immutable
final class Person {
  final String? name;
  final String? lastName;
  final int? age;
  final String? email;

  const Person({
    required this.name,
    required this.lastName,
    required this.age,
    required this.email,
  });

  Person copyWith({
    String? name,
    String? lastName,
    int? age,
    String? email,
  }) =>
      Person(
          name: name ?? this.name,
          lastName: lastName ?? this.lastName,
          age: age ?? this.age,
          email: email ?? this.email);

  Person clone() => copyWith(name: name, lastName: lastName, age: age, email: email);
}
