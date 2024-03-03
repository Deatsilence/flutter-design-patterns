import 'package:design_patterns/patterns/strategy/strategy_interface.dart';
import 'package:flutter/material.dart';

/// [CustomPageRoute] is the context
final class CustomPageRoute extends PageRouteBuilder {
  final Widget page;
  final PageTransitionStrategy transitionStrategy;

  CustomPageRoute({
    required this.page,
    required this.transitionStrategy,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              transitionStrategy.buildTransition(
                  context, animation, secondaryAnimation, child),
        );
}
