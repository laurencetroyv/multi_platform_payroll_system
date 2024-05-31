import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';

part 'employee_provider.g.dart';

@Riverpod(keepAlive: true)
class Employee extends _$Employee {
  @override
  EmployeeEntity build() {
    return EmployeeEntity.init();
  }

  void setEmployee(EmployeeEntity employee) {
    state = employee;
  }

  void updateEmployee(EmployeeEntity employee) {
    state = employee;
  }
}
