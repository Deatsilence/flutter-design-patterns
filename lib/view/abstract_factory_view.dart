import 'dart:developer';

import 'package:design_patterns/patterns/abstract_factory/abstract_factory.dart';
import 'package:flutter/material.dart';

class AbstractFactoryView extends StatelessWidget {
  const AbstractFactoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbstractFactoryImpl2.instance.buildButton(
              onPressed: () => log("Platform Button Pressed"),
              child: const Text("Platform Button"),
            ),
            AbstractFactoryImpl2.instance.buildIndicator(),
          ],
        ),
      ),
    );
  }
}
