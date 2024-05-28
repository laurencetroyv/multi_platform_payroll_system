import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';
import 'package:payroll_system/src/features/authentication/entities/authentication_entity.dart';

class AuthenticationProvider extends AsyncNotifier<AuthenticationEntity> {
  @override
  AuthenticationEntity build() {
    return AuthenticationEntity.init();
  }

  Future<void> login(SignInFormEntity form) async {
    try {
      final account = ref.read(accountProvider);
      final database = ref.read(databaseProvider);

      state = const AsyncLoading();

      final response = await account.createEmailPasswordSession(
        email: form.email,
        password: form.password,
      );

      final user = await database.getDocument(
        databaseId: EnvModel.database,
        collectionId: EnvModel.usersCollection,
        documentId: response.userId,
      );

      if ((kIsWeb || Platform.isWindows && form.saveSession == true) ||
          (Platform.isAndroid || Platform.isIOS)) {
        final secureStorage = ref.read(secureStorageProvider);
        secureStorage.delete(key: 'session');
        secureStorage.write(
          key: 'session',
          value: response.$id,
        );
      }

      state = AsyncData(AuthenticationEntity(
        isSignedIn: true,
        user: UserEntity.fromJson(
          user.data,
        ),
      ));
    } on AppwriteException catch (e) {
      Exception(e.message);
    }
  }

  Future<bool> signUp(SignUpFormEntity form) async {
    try {
      final account = ref.read(accountProvider);
      final database = ref.read(databaseProvider);

      final response = await account.create(
        userId: ID.unique(),
        email: form.email,
        password: form.password,
        name: form.name,
      );

      await database.createDocument(
        databaseId: EnvModel.database,
        collectionId: EnvModel.usersCollection,
        documentId: response.$id,
        data: form.toJson(),
      );

      return true;
    } on AppwriteException catch (e) {
      Exception(e.message);
    }
    return false;
  }

  Future<void> logout() async {
    final secureStorage = ref.read(secureStorageProvider);
    final account = ref.read(accountProvider);

    final sessionId = await secureStorage.read(key: 'session');
    await account.deleteSession(sessionId: sessionId!);
    secureStorage.delete(key: 'session');

    state = AsyncData(AuthenticationEntity(isSignedIn: false));
  }
}

final authenticationProvider =
    AsyncNotifierProvider<AuthenticationProvider, AuthenticationEntity>(() {
  return AuthenticationProvider();
});
