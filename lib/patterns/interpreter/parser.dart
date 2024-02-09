import 'package:design_patterns/patterns/interpreter/expression_interface.dart';

class WidgetParser {
  static List<WidgetExpression> parse(String input) {
    List<WidgetExpression> expressions = [];
    RegExp exp = RegExp(r'(\w+)\(([^)]+)\)'); // Basit bir regex pattern
    Iterable<RegExpMatch> matches = exp.allMatches(input);

    for (final match in matches) {
      String widgetType = match.group(1)!;
      String params = match.group(2)!;

      switch (widgetType.toLowerCase()) {
        case 'button':
          expressions.add(parseButton(params));
          break;
      }
    }

    return expressions;
  }

  static WidgetExpression parseButton(String params) {
    Map<String, String> paramsMap = parseParams(params);
    String text = paramsMap['text'] ?? '';
    String colorName = paramsMap['color'] ?? 'blue';

    return ButtonExpression(text, Colors.blue); // Basit renk dönüşümü
  }
}
