//! DART EXAMPLE
//? Why we should use factory method?:
//1-) Don't know what object to return
//2-) Localize logic to return object
//3-) Let Subclasses decide object to return
//4-) "Broader class" should be the data type

import 'dart:developer';

import 'package:design_patterns/enums/employee_type_enum.dart';

abstract class Employee {
  void work();
}

final class Programmer implements Employee {
  @override
  void work() {
    log("Programmer is working");
  }
}

final class HRManager implements Employee {
  @override
  void work() {
    log("HR Manager is working");
  }
}

final class Boss implements Employee {
  @override
  void work() {
    log("Boss is working");
  }
}

class EmployeeFactory {
  static Employee getEmployee(EmployeeType type) {
    switch (type) {
      case EmployeeType.programmer:
        return Programmer();
      case EmployeeType.hr:
        return HRManager();
      case EmployeeType.boss:
        return Boss();
      default:
        return Programmer();
    }
  }
}
