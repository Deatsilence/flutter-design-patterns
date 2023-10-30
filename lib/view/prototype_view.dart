import 'dart:developer';

import 'package:design_patterns/patterns/prototype/prototype.dart';
import 'package:flutter/material.dart';

class PrototypeView extends StatelessWidget {
  const PrototypeView({super.key});

  @override
  Widget build(BuildContext context) {
    const person1 = Person(name: "mert", lastName: "dogan", age: 23, email: "m@gmail");
    const person2 = Person(name: "mete", lastName: "dogan", age: 35, email: "m@gmail");
    final person3 = person1.clone();
    final person4 = person2.clone();

    log("${person3.name} ${person3.lastName}  ${person3.age}  ${person3.email} ");
    log("${person4.name} ${person4.lastName}  ${person4.age}  ${person4.email} ");

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
