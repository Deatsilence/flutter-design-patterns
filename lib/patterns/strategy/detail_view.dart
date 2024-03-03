import 'package:flutter/material.dart';

/// [DetailView] is the detail view for the strategy pattern
final class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail View'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go Back to Home View'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
