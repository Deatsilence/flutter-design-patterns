import 'package:design_patterns/patterns/iterator/model/photo.dart';
import 'package:design_patterns/patterns/iterator/photo_collection_aggregate.dart';
import 'package:design_patterns/view/chain_of_responsibility_view.dart';
import 'package:design_patterns/view/decorator_view.dart';
import 'package:design_patterns/view/fly_weight_view.dart';
import 'package:design_patterns/view/interpreter_view.dart';
import 'package:design_patterns/view/iterator_view.dart';
import 'package:design_patterns/view/proxy_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Design Patterns',
      home: InterpreterView(),
    );
  }
}
