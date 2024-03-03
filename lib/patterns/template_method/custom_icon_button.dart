import 'package:design_patterns/patterns/template_method/custom_button.dart';
import 'package:flutter/material.dart';

/// [IconCustomButton] is a concrete class
final class IconCustomButton extends CustomButton {
  final IconData icon;

  const IconCustomButton({super.key, required this.icon});

  @override
  Widget buildButtonContent() {
    return Icon(icon);
  }
}
