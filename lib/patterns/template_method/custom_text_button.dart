import 'package:design_patterns/patterns/template_method/custom_button.dart';
import 'package:flutter/material.dart';

/// [TextCustomButton] is a concrete class
final class TextCustomButton extends CustomButton {
  final String text;

  const TextCustomButton({super.key, required this.text});

  @override
  Widget buildButtonContent() {
    return Text(text);
  }
}
