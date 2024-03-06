import 'package:design_patterns/patterns/visitor/visitor_interface.dart';
import 'package:flutter/material.dart';

/// [VisitableWidget] is the interface for the elements in the object structure.
abstract class VisitableWidget {
  Widget accept(WidgetVisitor visitor);
}
