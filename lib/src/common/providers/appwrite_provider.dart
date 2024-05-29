import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:payroll_system/src/common/common.dart';

part 'appwrite_provider.g.dart';

@riverpod
Client client(ClientRef ref) {
  final client = Client();
  client.setEndpoint(EnvModel.endpoint).setProject(EnvModel.project);
  return client;
}

@riverpod
Databases databases(DatabasesRef ref) {
  final client = ref.read(clientProvider);
  return Databases(client);
}

@riverpod
Account account(AccountRef ref) {
  final client = ref.read(clientProvider);
  return Account(client);
}
