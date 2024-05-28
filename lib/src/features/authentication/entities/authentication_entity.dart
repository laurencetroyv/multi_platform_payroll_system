import 'package:payroll_system/src/common/common.dart';

class AuthenticationEntity {
  bool isSignedIn = false;
  UserEntity? user;

  AuthenticationEntity({required this.isSignedIn, this.user}) {
    if (isSignedIn && user == null) {
      throw ArgumentError('User must not be empty when isSignedIn is true');
    }
  }

  AuthenticationEntity copyWith({
    bool? isSignedIn,
    UserEntity? user,
  }) {
    if (isSignedIn == true && user == null) {
      throw ArgumentError('User must not be empty when isSignedIn is true');
    }
    return AuthenticationEntity(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      user: user ?? this.user,
    );
  }

  factory AuthenticationEntity.init() {
    return AuthenticationEntity(
      isSignedIn: false,
    );
  }
}
