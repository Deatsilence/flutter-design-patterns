import 'dart:developer';

import 'package:design_patterns/patterns/factory/flutter_factory_method.dart';
import 'package:flutter/material.dart';

class FactoryView extends StatelessWidget {
  const FactoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformButton().build(
              onPressed: () => log("IOS Button Pressed"),
              child: const Text("IOS Button"),
            ),
          ],
        ),
      ),
    );
  }
}
