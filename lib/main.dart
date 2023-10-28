import 'package:design_patterns/enums/employee_type_enum.dart';
import 'package:design_patterns/patterns/factory/dart_factory_method.dart';
import 'package:design_patterns/view/abstract_factory_view.dart';
import 'package:flutter/material.dart';

void main() {
  final employee = EmployeeFactory.getEmployee(EmployeeType.boss);
  employee.work();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Design Patterns',
      home: AbstractFactoryView(),
    );
  }
}
