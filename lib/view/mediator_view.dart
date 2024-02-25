import 'dart:developer';

import 'package:design_patterns/patterns/mediator/colleague.dart';
import 'package:design_patterns/patterns/mediator/concrate_mediator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// [MediatorView] is a widget that is a view in the mediator pattern.
final class MediatorView extends StatelessWidget {
  const MediatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mediator Design Pattern')),
      body: Column(
        children: [
          const QuestionWidget(question: "What is your favorite color ?"),
          const SizedBox(height: 10),
          const QuestionWidget(question: "What is your favorite meal ?"),
          ElevatedButton(
            onPressed: () => log(
                Provider.of<SurveyManager>(context, listen: false).responses.toString()),
            child: const Text('Show The Results'),
          ),
        ],
      ),
    );
  }
}
