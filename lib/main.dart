import 'package:design_patterns/view/builder_view.dart';
import 'package:design_patterns/view/prototype_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Design Patterns',
      home: BuilderView(),
    );
  }
}
