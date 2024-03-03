import 'package:design_patterns/patterns/strategy/strategy_interface.dart';
import 'package:flutter/material.dart';

/// [FadeTransitionStrategy] is a concrete strategy
final class FadeTransitionStrategy implements PageTransitionStrategy {
  @override
  Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

/// [SlideTransitionStrategy] is a concrete strategy
final class SlideTransitionStrategy implements PageTransitionStrategy {
  @override
  Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var begin = const Offset(1.0, 0.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end);
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }
}
