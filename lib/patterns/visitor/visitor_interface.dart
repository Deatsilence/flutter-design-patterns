import 'package:design_patterns/patterns/visitor/concrete_elements.dart';
import 'package:flutter/material.dart';

/// [WidgetVisitor] is the interface for the visitor pattern.
abstract class WidgetVisitor {
  Widget visitText(VisitableText text);
}
