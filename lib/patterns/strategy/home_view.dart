import 'package:design_patterns/patterns/strategy/concrete_strategies.dart';
import 'package:design_patterns/patterns/strategy/context.dart';
import 'package:design_patterns/patterns/strategy/detail_view.dart';
import 'package:flutter/material.dart';

/// [HomeView] is the main view for the strategy pattern
final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Detail View'),
          onPressed: () {
            Navigator.push(
              context,
              CustomPageRoute(
                page: const DetailView(),
                transitionStrategy: FadeTransitionStrategy(),
              ),
            );
          },
        ),
      ),
    );
  }
}
