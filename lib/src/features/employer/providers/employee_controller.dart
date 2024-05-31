import 'package:appwrite/appwrite.dart';
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

  Future<void> addEmployee(EmployeeEntity employee) async {
    final index = employeeIndex(employee.id);
    if (index == -1) {
      state = [...state, employee];
      final database = ref.read(databasesProvider);
      final response = await database.createDocument(
        databaseId: EnvModel.database,
        collectionId: EnvModel.employeeCollection,
        documentId: ID.unique(),
        data: employee.toJson(),
      );

      final employeeId = EmployeeIds(
        id: employee.id,
        employerId: employee.employerId,
        reference: response.$id,
      );

      await database.createDocument(
        databaseId: EnvModel.database,
        collectionId: EnvModel.employeeIdsCollection,
        documentId: ID.unique(),
        data: employeeId.toJson(),
      );
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

  Future<void> fetchEmployees(UserEntity user) async {
    final database = ref.read(databasesProvider);

    final response = await database.listDocuments(
      databaseId: EnvModel.database,
      collectionId: EnvModel.employeeCollection,
      queries: [Query.equal('employerId', user.id)],
    );

    final employees = response.documents.map((employee) {
      return EmployeeEntity.fromMap(employee.data);
    }).toList();

    state = employees;
  }

  Future<EmployeeEntity> getEmployee(String id) async {
    final database = ref.read(databasesProvider);

    final response = await database.getDocument(
      databaseId: EnvModel.database,
      collectionId: EnvModel.employeeCollection,
      documentId: id,
    );

    return EmployeeEntity.fromMap(response.data);
  }
}
