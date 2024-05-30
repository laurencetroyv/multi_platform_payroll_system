import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';

part 'employee_controller.g.dart';

@Riverpod(keepAlive: true)
class EmployeeController extends _$EmployeeController {
  @override
  List<EmployeeEntity> build() => [];

  int employeeIndex(String id) {
    return state.indexWhere((e) => e.id == id);
  }

  void addEmployee(EmployeeEntity employee) {
    final index = employeeIndex(employee.id);
    if (index == -1) {
      state = [...state, employee];
    }
  }

  void removeEmployee(EmployeeEntity employee) {
    final index = employeeIndex(employee.id);
    if (index != -1) {
      state = state.where((employee) => employee != employee).toList();
    }
  }

  void disableEmployee(EmployeeEntity employee) {
    final index = employeeIndex(employee.id);
    if (index != -1) {
      state[index] = state[index].copyWith(status: !employee.status);
    }
  }
}
