import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';

part 'authentication_provider.g.dart';

@riverpod
class Authentication extends _$Authentication {
  @override
  FutureOr<AuthenticationEntity> build() async {
    state = const AsyncLoading();

    final session = ref.read(readSessionProvider).value;

    if (session != null && session.isNotEmpty) {
      final user = await getUser(session);
      state = AsyncData(user);
      return user;
    } else {
      final user = AuthenticationEntity.init();
      state = AsyncData(user);
      return user;
    }
  }

  Future<void> login(SignInFormEntity form) async {
    try {
      final account = ref.read(accountProvider);
      final database = ref.read(databasesProvider);

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

      final authState = AuthenticationEntity(
        isSignedIn: true,
        user: UserEntity.fromJson(user.data),
      );

      state = AsyncData(authState);
    } on AppwriteException catch (e) {
      Exception(e.message);
    }
  }

  Future<bool> signUp(SignUpFormEntity form) async {
    try {
      final account = ref.read(accountProvider);
      final database = ref.read(databasesProvider);

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

  Future<AuthenticationEntity> getUser(String session) async {
    final account = ref.read(accountProvider);
    final database = ref.read(databasesProvider);

    final userSession = await account.getSession(sessionId: session);

    final user = await database.getDocument(
      databaseId: EnvModel.database,
      collectionId: EnvModel.usersCollection,
      documentId: userSession.userId,
    );

    final authState = AuthenticationEntity(
      isSignedIn: true,
      user: UserEntity.fromJson(user.data),
    );

    return authState;
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
