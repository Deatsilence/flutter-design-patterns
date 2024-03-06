import 'package:design_patterns/patterns/visitor/concrete_elements.dart';
import 'package:design_patterns/patterns/visitor/concrete_visitor.dart';
import 'package:flutter/material.dart';

/// [VisitorView] is a view that visitor design pattern is implemented.
final class VisitorView extends StatefulWidget {
  const VisitorView({super.key});

  @override
  State<VisitorView> createState() => _VisitorViewState();
}

class _VisitorViewState extends State<VisitorView> {
  late double _currentPadding;

  @override
  void initState() {
    _currentPadding = 0;
    super.initState();
  }

  void increasePadding() {
    setState(() {
      _currentPadding += 10;
    });
  }

  void decreasePadding() {
    setState(() {
      if (_currentPadding > 0) {
        _currentPadding = _currentPadding - 10;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final paddingAdjuster = PaddingAdjuster(padding: _currentPadding);

    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Pattern')),
      body: const VisitableText(text: 'Hello Visitor').accept(paddingAdjuster),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: increasePadding,
            mini: true,
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: decreasePadding,
            mini: true,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
