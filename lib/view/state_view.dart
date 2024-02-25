import 'package:design_patterns/patterns/state/state.dart';
import 'package:flutter/material.dart';

/// [StateView] is a widget that is a view in the state pattern.
final class StateView extends StatelessWidget {
  const StateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CartWidget();
  }
}
