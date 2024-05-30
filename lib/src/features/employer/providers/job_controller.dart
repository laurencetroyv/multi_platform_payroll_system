import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'job_controller.g.dart';

@riverpod
class JobController extends _$JobController {
  @override
  List<String> build() => [];

  void addJobPosition(String position) {
    if (!state.contains(position)) {
      state = [...state, position];
    }
  }

  void removeJobPosition(String position) {
    if (state.contains(position)) {
      state = state.where((element) => element != position).toList();
    }
  }
}
