import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_controller.g.dart';

@riverpod
class EmployeeController extends _$EmployeeController {
  @override
  int build() => 0;

  void addEmployee() {
    state++;
  }

  void removeEmployee() {
    if (state > 0) {
      state--;
    }
  }
}
