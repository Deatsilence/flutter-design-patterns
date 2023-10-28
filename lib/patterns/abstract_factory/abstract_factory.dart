import 'package:design_patterns/patterns/factory/platform_indicator.dart';
import 'package:design_patterns/patterns/factory/platform_button.dart';
import 'package:flutter/material.dart';

final class AbstractFactoryImpl {
  static Widget buildButton({required VoidCallback onPressed, required Widget child}) {
    return PlatformButton().build(onPressed: onPressed, child: child);
  }

  static Widget buildIndicator() {
    return PlatformIndicator().build();
  }
}
