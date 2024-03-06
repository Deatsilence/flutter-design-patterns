import 'package:design_patterns/patterns/visitor/element_interface.dart';
import 'package:design_patterns/patterns/visitor/visitor_interface.dart';
import 'package:flutter/material.dart';

/// [VisitableText] is a concrete element that implements the [CustomWidget] interface.
final class VisitableText extends StatelessWidget implements VisitableWidget {
  final String text;

  const VisitableText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }

  @override
  Widget accept(WidgetVisitor visitor) {
    return visitor.visitText(this);
  }
}
