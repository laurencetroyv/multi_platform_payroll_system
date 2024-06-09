import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';

part 'cash_advance_controller.g.dart';

@Riverpod(keepAlive: true)
class CashAdvanceController extends _$CashAdvanceController {
  @override
  List<CashAdvanceEntity> build() => [];

  void addCashAdvanceEmployee() {}

  void removeCashAdvanceEmployee() {}

  Future<void> fetchCashAdvanceEmployee(UserEntity user) async {
    final database = ref.read(databasesProvider);

    final response = await database.listDocuments(
      databaseId: EnvModel.database,
      collectionId: EnvModel.cashAdvanceCollection,
      queries: [Query.equal('employerId', user.id)],
    );

    final cashAdvances = response.documents.map((cashAdvance) {
      return CashAdvanceEntity.fromMap(cashAdvance.data);
    }).toList();

    state = cashAdvances;
  }

  Future<void> postCashAdvanceEmployee(CashAdvanceEntity cashAdvance) async {
    final database = ref.read(databasesProvider);

    await database.createDocument(
      databaseId: EnvModel.database,
      collectionId: EnvModel.cashAdvanceCollection,
      documentId: ID.unique(),
      data: cashAdvance.toJson(),
    );

    state = [...state, cashAdvance];
  }

  Future<void> fetchCashAdvanceEmployeeEmployee(EmployeeEntity employee) async {
    final database = ref.read(databasesProvider);

    final response = await database.listDocuments(
      databaseId: EnvModel.database,
      collectionId: EnvModel.cashAdvanceCollection,
      queries: [
        Query.and([
          Query.equal('employerId', employee.employerId),
          Query.equal('userId', employee.id)
        ])
      ],
    );

    final cashAdvance = response.documents.map((cashAdvance) {
      return CashAdvanceEntity.fromMap(cashAdvance.data);
    }).toList();

    state = cashAdvance;
  }

  Future<void> approveCashAdvanced(String id) async {
    final database = ref.read(databasesProvider);

    await database.updateDocument(
      databaseId: EnvModel.database,
      collectionId: EnvModel.cashAdvanceCollection,
      documentId: id,
      data: {'active': true},
    );
  }
}
