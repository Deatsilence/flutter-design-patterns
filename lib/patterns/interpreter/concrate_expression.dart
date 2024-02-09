import 'package:design_patterns/patterns/interpreter/expression_interface.dart';
import 'package:flutter/material.dart';

/// [ButtonExpression] is a concrete expression
final class ButtonExpression implements WidgetExpression {
  final String text;
  final Color color;

  ButtonExpression(this.text, this.color);

  @override
  Widget interpret() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(text),
    );
  }
}
