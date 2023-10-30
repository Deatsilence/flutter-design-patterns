import 'dart:developer';

import 'package:design_patterns/patterns/prototype/prototype.dart';
import 'package:flutter/material.dart';

class PrototypeView extends StatelessWidget {
  const PrototypeView({super.key});

  @override
  Widget build(BuildContext context) {
    const person1 = Person(name: "mert", lastName: "dogan", age: 23, email: "m@gmail");
    const person2 = Person(name: "mert", lastName: "dogan", age: 23, email: "m@gmail");
    person1 == person2 ? log("true") : log("false");
    final person3 = person1.clone();
    person1 == person3 ? log("true") : log("false");

    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
