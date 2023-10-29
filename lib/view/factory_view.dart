import 'dart:developer';

import 'package:design_patterns/enums/employee_type_enum.dart';
import 'package:design_patterns/patterns/factory/dart_factory_method.dart';
import 'package:design_patterns/patterns/factory/platform_button.dart';
import 'package:flutter/material.dart';

class FactoryView extends StatelessWidget {
  FactoryView({super.key});

  final employee = EmployeeFactory.getEmployee(EmployeeType.boss).work();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformButton().build(
              onPressed: () => log("IOS Button Pressed"),
              child: const Text("IOS Button"),
            ),
          ],
        ),
      ),
    );
  }
}
