import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';

part 'employee_controller.g.dart';

@riverpod
class EmployeeController extends _$EmployeeController {
  @override
  List<EmployeeEntity> build() => [];

  void addEmployee(EmployeeEntity employee) {
    if (!state.contains(employee)) {
      state = [...state, employee];
    }
  }

  void removeEmployee(EmployeeEntity employee) {
    if (state.contains(employee)) {
      state = state.where((employee) => employee != employee).toList();
    }
  }
}
