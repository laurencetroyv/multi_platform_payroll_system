import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';
import 'package:payroll_system/src/features/authentication/authentication.dart';
import 'package:payroll_system/src/features/employee/provider/employee_provider.dart';
import 'package:payroll_system/src/features/employer/employer.dart';

part 'authentication_provider.g.dart';

@Riverpod(keepAlive: true)
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
        ref.read(deleteSessionProvider('session'));
        ref.read(setSessionProvider("session", response.$id));
      }

      final userEntity = UserEntity.fromJson(user.data, response.$id);

      final authState = AuthenticationEntity(
        isSignedIn: true,
        user: userEntity,
      );

      if (userEntity.role == UserRoles.employer) {
        await ref
            .read(jobControllerProvider.notifier)
            .fetchJobPositions(userEntity);

        await ref
            .read(employeeControllerProvider.notifier)
            .fetchEmployees(userEntity);

        await ref
            .read(cashAdvanceControllerProvider.notifier)
            .fetchCashAdvanceEmployee(userEntity);

        await ref
            .read(paidControllerProvider.notifier)
            .fetchPaidEmployees(userEntity);
      } else {
        final employeeIds = await getEmployeeIds();

        final employeeId = employeeIds.firstWhere(
          (element) => element.id == userEntity.employeeId,
          orElse: () => EmployeeIds(id: '', employerId: '', reference: ''),
        );

        final employee = await ref
            .read(employeeControllerProvider.notifier)
            .getEmployee(employeeId.reference);

        ref.read(employeeProvider.notifier).setEmployee(employee);

        // fetch job of employee
        await ref
            .read(jobControllerProvider.notifier)
            .fetchJobPositionEmployee(employee);

        // fetch cash advances of employee
        await ref
            .read(cashAdvanceControllerProvider.notifier)
            .fetchCashAdvanceEmployeeEmployee(employee);
        // fetch paids of employee
        await ref
            .read(paidControllerProvider.notifier)
            .fetchPaidEmployeesEmployee(employee);
      }

      ref.read(userControllerProvider.notifier).setUser(userEntity);

      state = AsyncData(authState);
    } on AppwriteException catch (e) {
      Exception(e.message);
    }
  }

  Future<bool> signUp(SignUpFormEntity form, {String? name}) async {
    try {
      final account = ref.read(accountProvider);
      final database = ref.read(databasesProvider);

      final response = await account.create(
        userId: ID.unique(),
        email: form.email,
        password: form.password,
        name: form.name.isNotEmpty ? form.name : name,
      );

      await database.createDocument(
        databaseId: EnvModel.database,
        collectionId: EnvModel.usersCollection,
        documentId: response.$id,
        data: form.toJson(name: name),
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
      user: UserEntity.fromJson(user.data, userSession.$id),
    );

    return authState;
  }

  Future<List<EmployeeIds>> getEmployeeIds() async {
    try {
      final database = ref.read(databasesProvider);

      final response = await database.listDocuments(
        databaseId: EnvModel.database,
        collectionId: EnvModel.employeeIdsCollection,
      );

      final employeeIds =
          response.documents.map((e) => EmployeeIds.fromMap(e.data)).toList();

      return employeeIds;
    } on AppwriteException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> logout() async {
    final session = ref.read(userControllerProvider).session;
    final account = ref.read(accountProvider);
    await account.deleteSession(sessionId: session!);

    state = AsyncData(AuthenticationEntity(isSignedIn: false));
  }
}
