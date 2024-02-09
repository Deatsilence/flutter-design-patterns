import 'package:design_patterns/patterns/interpreter/concrate_expression.dart';
import 'package:design_patterns/patterns/interpreter/expression_interface.dart';
import 'package:flutter/material.dart';

final class WidgetParser {
  List<WidgetExpression> parseScript(String script) {
    List<WidgetExpression> expressions = [];
    for (String line in script.split('\n')) {
      line = line.trim();
      if (line.isEmpty) continue;

      /// for example: Text("Hello World")
      if (line.startsWith("Text:")) {
        String text = line.substring(5, line.length);
        expressions.add(
          ConcreteExpressionText(
            text: text,
            style: const TextStyle(fontSize: 20),
          ),
        );
        continue;
      }

      /// for example: Image:https://example.com/image.png
      if (line.startsWith("Image:") && line.contains("https://")) {
        String url = line.substring(6, line.length);
        debugPrint(url);
        List<String> parts = url.split(',');
        String urlTrimmed = parts[0].trim();
        expressions.add(ConcreteExpressionImage(url: urlTrimmed));
        continue;
      }
    }
    return expressions;
  }
}
