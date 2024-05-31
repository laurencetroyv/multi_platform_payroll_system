import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_index.g.dart';

@riverpod
class EmployeeIndex extends _$EmployeeIndex {
  @override
  int build() => 0;

  void setIndex(int value) => state = value;
}
