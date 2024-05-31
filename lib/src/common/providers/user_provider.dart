import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserController extends _$UserController {
  @override
  UserEntity build() {
    return UserEntity.init();
  }

  void setUser(UserEntity user) {
    state = user;
  }

  void clearUser() {
    state = UserEntity.init();
  }
}
