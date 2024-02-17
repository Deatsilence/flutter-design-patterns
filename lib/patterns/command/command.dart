import 'package:flutter/material.dart';

/// [TextCommand] is the abstract class for the Command Pattern.
abstract class TextCommand {
  void execute();
  void undo();
}

/// [UpdateTextCommand] is the concrete class for the Command Pattern.
final class UpdateTextCommand implements TextCommand {
  final TextEditingController controller;
  final String newText;
  String oldText;

  UpdateTextCommand(this.controller, this.newText) : oldText = controller.text;

  @override
  void execute() {
    controller.text = newText;
  }

  @override
  void undo() {
    controller.text = oldText;
  }
}

/// [TextEditorController] is the Invoker class for the Command Pattern.
final class TextEditorController {
  final List<TextCommand> _commandHistory = [];
  int _currentCommandIndex = -1;

  void executeCommand(TextCommand command) {
    if (_currentCommandIndex != _commandHistory.length - 1) {
      _commandHistory.removeRange(_currentCommandIndex + 1, _commandHistory.length);
    }
    _commandHistory.add(command);
    _currentCommandIndex++;
    command.execute();
  }

  void undo() {
    if (_currentCommandIndex >= 0) {
      _commandHistory[_currentCommandIndex].undo();
      _currentCommandIndex--;
    }
  }

  void redo() {
    if (_currentCommandIndex < _commandHistory.length - 1) {
      _currentCommandIndex++;
      _commandHistory[_currentCommandIndex].execute();
    }
  }
}
