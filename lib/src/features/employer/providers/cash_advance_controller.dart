import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cash_advance_controller.g.dart';

@riverpod
class CashAdvanceController extends _$CashAdvanceController {
  @override
  int build() => 0;

  void addCashAdvanceEmployee() {
    state++;
  }

  void removeCashAdvanceEmployee() {
    if (state > 0) {
      state--;
    }
  }
}
