import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'paid_controller.g.dart';

@riverpod
class PaidController extends _$PaidController {
  @override
  int build() => 0;

  void addPaidEmployee() {
    state++;
  }

  void removePaidEmployee() {
    if (state > 0) {
      state--;
    }
  }
}
