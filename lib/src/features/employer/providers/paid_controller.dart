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

  void addPaidEmployee(PaymentEntity paymentEntity) {
    final index = getIndex(paymentEntity.id);
    if (index == -1) {
      state.add(paymentEntity);
    }
  }

  void removePaidEmployee(PaymentEntity paymentEntity) {
    final index = getIndex(paymentEntity.id);
    if (index != -1) {
      state.removeAt(index);
    }
  }
}
