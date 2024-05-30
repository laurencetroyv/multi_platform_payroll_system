import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employer_index.g.dart';

@riverpod
class EmployerIndex extends _$EmployerIndex {
  @override
  int build() => 0;

  void setIndex(int value) => state = value;
}
