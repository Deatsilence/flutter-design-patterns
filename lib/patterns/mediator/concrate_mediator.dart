// Concrete Mediator

import 'package:design_patterns/patterns/mediator/mediator_interface.dart';
import 'package:flutter/material.dart';

/// [SurveyManager] is the concrete mediator
final class SurveyManager extends ChangeNotifier implements SurveyMediator {
  final Map<String, String> responses = {};

  @override
  void submitAnswer(String question, String answer) {
    responses[question] = answer;
    notifyListeners();
  }
}
