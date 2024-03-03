import 'package:design_patterns/patterns/template_method/custom_icon_button.dart';
import 'package:design_patterns/patterns/template_method/custom_text_button.dart';
import 'package:flutter/material.dart';

/// [TempleteMethodView] is the main view for the template method pattern
final class TempleteMethodView extends StatelessWidget {
  const TempleteMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Template Method Example')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextCustomButton(text: 'Text Button'),
            IconCustomButton(icon: Icons.add),
            // ... other buttons
          ],
        ),
      ),
    );
  }
}
