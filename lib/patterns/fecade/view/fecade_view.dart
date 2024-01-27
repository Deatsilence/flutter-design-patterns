import 'package:design_patterns/patterns/fecade/fecade_service.dart';
import 'package:flutter/material.dart';

final class FecadeView extends StatefulWidget {
  const FecadeView({super.key});

  @override
  State<FecadeView> createState() => _FecadeViewState();
}

class _FecadeViewState extends State<FecadeView> {
  ApiFacadeService? _apiFacadeService;

  @override
  void initState() {
    super.initState();
    _apiFacadeService = ApiFacadeService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _apiFacadeService != null
            ? FutureBuilder(
                future: _apiFacadeService!.getNews(),
                //! future: _apiFacadeService!.getUserProfile(),
                //! future: _apiFacadeService!.getWeather(),
                builder: (context, snapshot) => const Text("data"),
              )
            : const Text('an error occured'),
      ),
    );
  }
}
