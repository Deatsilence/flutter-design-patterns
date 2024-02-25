import 'package:design_patterns/patterns/mediator/concrate_mediator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// [ColleagueWidget] is a widget that is a colleague in the mediator pattern.
final class QuestionWidget extends StatelessWidget {
  final String question;

  const QuestionWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(question),
        TextField(
          onChanged: (answer) {
            Provider.of<SurveyManager>(context, listen: false)
                .submitAnswer(question, answer);
          },
        ),
      ],
    );
  }
}
