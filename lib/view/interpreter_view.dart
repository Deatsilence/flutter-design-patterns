import 'package:design_patterns/patterns/interpreter/expression_interface.dart';
import 'package:design_patterns/patterns/interpreter/parser.dart';
import 'package:flutter/material.dart';

final class InterpreterView extends StatefulWidget {
  const InterpreterView({super.key});

  @override
  State<InterpreterView> createState() => _InterpreterViewState();
}

class _InterpreterViewState extends State<InterpreterView> {
  String? _script;
  List<WidgetExpression>? _expressions;

  @override
  void initState() {
    super.initState();
    _script = "";
    _expressions = WidgetParser().parseScript(_script ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interpreter Pattern"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: _script),
              onChanged: (value) {
                _script = value;
              },
              decoration: const InputDecoration(
                labelText: "Command Script",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _expressions = WidgetParser().parseScript(_script ?? "");
                setState(() {});
              },
              child: const Text("Comment the script"),
            ),
            const SizedBox(height: 16.0),
            if (_expressions != null && _expressions!.isNotEmpty)
              _expressions!.first.interpret(context),
          ],
        ),
      ),
    );
  }
}
