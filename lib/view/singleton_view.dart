import 'dart:developer';

import 'package:design_patterns/patterns/abstract_factory/abstract_factory.dart';
import 'package:design_patterns/patterns/singleton/singleton.dart';
import 'package:flutter/material.dart';

class SingletonView extends StatelessWidget {
  SingletonView({super.key});

  final s1 = Singleton.instance;
  final s2 = Singleton.instance;
  final s3 = Singleton.instance;

  final s4 = SingletonWithFactory();
  final s5 = SingletonWithFactory();
  final s6 = SingletonWithFactory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbstractFactoryImpl.buildButton(
              onPressed: () => log("IOS Button1 Pressed"),
              child: const Icon(Icons.apple_outlined),
            ),
            AbstractFactoryImpl.buildIndicator(),
            AbstractFactoryImpl2.instance.buildButton(
              onPressed: () => log("IOS Button2 Pressed"),
              child: const Text("IOS Button"),
            ),
            AbstractFactoryImpl2.instance.buildIndicator(),
          ],
        ),
      ),
    );
  }
}
