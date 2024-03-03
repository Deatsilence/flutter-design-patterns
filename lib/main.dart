import 'package:design_patterns/patterns/iterator/model/photo.dart';
import 'package:design_patterns/patterns/iterator/photo_collection_aggregate.dart';
import 'package:design_patterns/patterns/mediator/concrate_mediator.dart';
import 'package:design_patterns/patterns/strategy/home_view.dart';
import 'package:design_patterns/view/chain_of_responsibility_view.dart';
import 'package:design_patterns/view/command_view.dart';
import 'package:design_patterns/view/decorator_view.dart';
import 'package:design_patterns/view/fly_weight_view.dart';
import 'package:design_patterns/view/interpreter_view.dart';
import 'package:design_patterns/view/iterator_view.dart';
import 'package:design_patterns/view/mediator_view.dart';
import 'package:design_patterns/view/observer_view.dart';
import 'package:design_patterns/view/proxy_view.dart';
import 'package:design_patterns/view/state_view.dart';
import 'package:design_patterns/view/strategy_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SurveyManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Design Patterns',
      home: StrategyView(),
    );
  }
}
