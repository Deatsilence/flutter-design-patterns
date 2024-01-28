import 'package:design_patterns/view/decorator_view.dart';
import 'package:design_patterns/view/fly_weight_view.dart';
import 'package:design_patterns/view/proxy_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Design Patterns',
      home: ProxyView(),
    );
  }
}
