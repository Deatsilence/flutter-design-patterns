import 'package:design_patterns/patterns/momento/origantor.dart';
import 'package:flutter/material.dart';

/// [MomentoView] is a StatelessWidget that uses [ShoppingCartWidget] as an Originator.
final class MomentoView extends StatelessWidget {
  const MomentoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShoppingCartWidget();
  }
}
