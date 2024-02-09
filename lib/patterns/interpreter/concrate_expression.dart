import 'package:design_patterns/patterns/interpreter/expression_interface.dart';
import 'package:flutter/material.dart';

/// [ConcreteExpressionText] is the concrete expression for the text
final class ConcreteExpressionText implements WidgetExpression {
  final String text;
  final TextStyle style;

  ConcreteExpressionText({required this.text, required this.style});

  @override
  Widget interpret(BuildContext? context) => Text(text, style: style);
}

/// [ConcreteExpressionButton] is the concrete expression for the button
final class ConcreteExpressionImage implements WidgetExpression {
  final String url;

  ConcreteExpressionImage({
    required this.url,
  });

  @override
  Widget interpret(BuildContext? context) => Image.network(url, width: 100, height: 100);
}
