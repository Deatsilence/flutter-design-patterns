import 'package:flutter/material.dart';

/// [PageTransitionStrategy] is the strategy interface
abstract class PageTransitionStrategy {
  Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  );
}
