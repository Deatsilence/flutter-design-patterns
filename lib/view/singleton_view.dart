import 'package:design_patterns/patterns/singleton/model/place_model.dart';
import 'package:design_patterns/patterns/singleton/singleton.dart';
import 'package:design_patterns/patterns/singleton/singleton_network_manager.dart';
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

  late final response;
  @override
  void initState() {
    PredictionsNetworkManager.instance.dioGet<Place>("Ankara", Place()).then((value) => response = value);
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
            ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                if (response is Place) {
                  return Text("${(response as Place).name}");
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
