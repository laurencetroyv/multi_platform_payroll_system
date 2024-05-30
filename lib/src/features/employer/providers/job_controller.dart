import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';

part 'job_controller.g.dart';

@Riverpod(keepAlive: true)
class JobController extends _$JobController {
  @override
  List<JobEntity> build() => [];

  int getIndex(JobEntity job) {
    return state.indexWhere((element) => element.id == job.id);
  }

  void addJobPosition(JobEntity position) {
    final index = getIndex(position);
    if (index == -1) {
      state = [...state, position];
    }
  }

  void removeJobPosition(JobEntity position) {
    final index = getIndex(position);
    if (index != -1) {
      state =
          state.where((element) => element.title != position.title).toList();
    }
  }

  void updateJobPosition(JobEntity position) {
    final index = getIndex(position);
    if (index != -1) {
      state[index] = position;
    }
  }
}
