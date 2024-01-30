import 'package:design_patterns/patterns/chain_of_responsibility/concrete_handlers.dart';
import 'package:flutter/material.dart';

/// [ChainOfResponsibilityView] is the view that shows the Chain of Responsibility Pattern.
final class ChainOfResponsibilityView extends StatefulWidget {
  const ChainOfResponsibilityView({super.key});

  @override
  State<ChainOfResponsibilityView> createState() => _ChainOfResponsibilityViewState();
}

class _ChainOfResponsibilityViewState extends State<ChainOfResponsibilityView> {
  @override
  Widget build(BuildContext context) {
    var buttonHandler = ButtonInteractionHandler();
    var formHandler = FormInteractionHandler();

    buttonHandler.setNextHandler(formHandler);

    return Scaffold(
      appBar: AppBar(title: const Text("Chain of Responsibility in Flutter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => buttonHandler.handleInteraction('buttonClick', context),
              child: const Text('Click Me'),
            ),
            ElevatedButton(
              onPressed: () => buttonHandler.handleInteraction('formSubmit', context),
              child: const Text('Submit Form'),
            ),
            ElevatedButton(
              onPressed: () => buttonHandler.handleInteraction('unknown', context),
              child: const Text('unknown'),
            ),
          ],
        ),
      ),
    );
  }
}
