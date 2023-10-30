import 'dart:developer';

import 'package:design_patterns/patterns/abstract_factory/abstract_factory.dart';
import 'package:design_patterns/patterns/singleton/singleton.dart';
import 'package:flutter/material.dart';

class SingletonView extends StatefulWidget {
  const SingletonView({super.key});

  @override
  State<SingletonView> createState() => _SingletonViewState();
}

class _SingletonViewState extends State<SingletonView> {
  final s1 = Singleton.instance;
  final s2 = Singleton.instance;
  final s3 = Singleton.instance;

  final s4 = SingletonWithFactory();
  final s5 = SingletonWithFactory();
  final s6 = SingletonWithFactory();

  // late final response;
  @override
  void initState() {
    //! This is a dummy example logic at below. So it doesn't work
    // PredictionsNetworkManager.instance.dioGet<Place>("Ankara", Place()).then((value) => response = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbstractFactoryImpl2.instance.buildButton(
              onPressed: () => log("Pressed onto Platform Button"),
              child: const Text("Platform Button"),
            ),
            AbstractFactoryImpl2.instance.buildIndicator(),
            //! This is a dummy example logic at below. So it doesn't work
            // ListView.builder(
            //   itemCount: 1,
            //   itemBuilder: (BuildContext context, int index) {
            //     if (response is Place) {
            //       return Text("${(response as Place).name}");
            //     }
            //     return null;
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
