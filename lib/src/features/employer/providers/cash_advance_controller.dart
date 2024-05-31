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
}
