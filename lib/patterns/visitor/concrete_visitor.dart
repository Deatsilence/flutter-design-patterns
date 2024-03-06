// Somut bir Ziyaretçi
import 'package:design_patterns/patterns/visitor/concrete_elements.dart';
import 'package:design_patterns/patterns/visitor/visitor_interface.dart';
import 'package:flutter/material.dart';

/// [PaddingAdjuster] is a concrete visitor that implements the [WidgetVisitor] interface.
final class PaddingAdjuster implements WidgetVisitor {
  final double padding;

  PaddingAdjuster({required this.padding});

  @override
  Widget visitText(VisitableText text) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: text,
    );
  }
}
