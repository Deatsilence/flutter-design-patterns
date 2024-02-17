import 'package:design_patterns/patterns/command/command.dart';
import 'package:flutter/material.dart';

/// [CommandView] is the view that shows the Command Pattern.
final class CommandView extends StatelessWidget {
  final TextEditorController controller = TextEditorController();
  final TextEditingController textEditingController = TextEditingController();

  CommandView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Command Pattern in Flutter')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              onChanged: (text) {
                controller.executeCommand(UpdateTextCommand(textEditingController, text));
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.undo();
            },
            child: const Text('Undo'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.redo();
            },
            child: const Text('Redo'),
          ),
        ],
      ),
    );
  }
}
