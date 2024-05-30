import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/entities/cash_advance_entity.dart';

part 'cash_advance_controller.g.dart';

@Riverpod(keepAlive: true)
class CashAdvanceController extends _$CashAdvanceController {
  @override
  List<CashAdvanceEntity> build() => [];

  void addCashAdvanceEmployee() {}

  void removeCashAdvanceEmployee() {}
}
