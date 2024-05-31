import 'package:appwrite/appwrite.dart';
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

  Future<void> addJobPosition(JobEntity position) async {
    final index = getIndex(position);
    if (index == -1) {
      final database = ref.read(databasesProvider);
      await database.createDocument(
        databaseId: EnvModel.database,
        collectionId: EnvModel.jobPositionsCollection,
        documentId: ID.unique(),
        data: position.toJson(),
      );
      state = [...state, position];
    }
  }

  Future<void> fetchJobPositions(UserEntity user) async {
    final database = ref.read(databasesProvider);

    final response = await database.listDocuments(
      databaseId: EnvModel.database,
      collectionId: EnvModel.jobPositionsCollection,
      queries: [Query.equal('employerId', user.id)],
    );

    final jobs = response.documents.map((job) {
      return JobEntity.fromMap(job.data);
    }).toList();

    state = jobs;
  }

  Future<JobEntity> fetchJobPositionEmployee(EmployeeEntity employee) async {
    final database = ref.read(databasesProvider);

    final response = await database.listDocuments(
      databaseId: EnvModel.database,
      collectionId: EnvModel.jobPositionsCollection,
      queries: [
        Query.and([
          Query.equal('employerId', employee.employerId),
          Query.equal('id', employee.jobId)
        ])
      ],
    );

    final jobs = response.documents.map((job) {
      return JobEntity.fromMap(job.data);
    }).toList();

    state = jobs;

    return jobs.first;
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
