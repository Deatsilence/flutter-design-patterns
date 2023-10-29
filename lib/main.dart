import 'dart:developer';

import 'package:design_patterns/patterns/prototype/prototype.dart';
import 'package:design_patterns/view/singleton_view.dart';
import 'package:flutter/material.dart';

void main() {
  const person1 = Person(name: "mert", lastName: "dogan", age: 23, email: "m@gmail");
  const person2 = Person(name: "mert", lastName: "dogan", age: 23, email: "m@gmail");
  person1 == person2 ? log("true") : log("false");
  final person3 = person1.clone();
  person1 == person3 ? log("true") : log("false");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Patterns',
      home: SingletonView(),
    );
  }
}
