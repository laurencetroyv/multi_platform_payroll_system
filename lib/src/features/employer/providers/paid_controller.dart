import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';

part 'paid_controller.g.dart';

@Riverpod(keepAlive: true)
class PaidController extends _$PaidController {
  @override
  List<PaymentEntity> build() => [];

  int getIndex(String id) {
    return state.indexWhere((element) => element.id == id);
  }

  Future<void> addPaidEmployee(PaymentEntity paymentEntity) async {
    final index = getIndex(paymentEntity.id);
    if (index == -1) {
      state.add(paymentEntity);
      final database = ref.read(databasesProvider);
      await database.createDocument(
        databaseId: EnvModel.database,
        collectionId: EnvModel.paymentsCollection,
        documentId: ID.unique(),
        data: paymentEntity.toJson(),
      );
    }
  }

  void removePaidEmployee(PaymentEntity paymentEntity) {
    final index = getIndex(paymentEntity.id);
    if (index != -1) {
      state.removeAt(index);
    }
  }

  Future<void> fetchPaidEmployees(UserEntity user) async {
    final database = ref.read(databasesProvider);

    final response = await database.listDocuments(
      databaseId: EnvModel.database,
      collectionId: EnvModel.paymentsCollection,
      queries: [Query.equal('employerId', user.id)],
    );

    final payments = response.documents.map((payment) {
      return PaymentEntity.fromMap(payment.data);
    }).toList();

    state = payments;
  }

  Future<void> fetchPaidEmployeesEmployee(EmployeeEntity employee) async {
    try {
      final database = ref.read(databasesProvider);

      final response = await database.listDocuments(
        databaseId: EnvModel.database,
        collectionId: EnvModel.paymentsCollection,
        queries: [
          Query.equal('employeeId', employee.id),
        ],
      );

      final payments = response.documents.map((payment) {
        return PaymentEntity.fromMap(payment.data);
      }).toList();

      state = payments;
    } on AppwriteException catch (e) {
      throw Exception(e.message);
    }
  }
}
