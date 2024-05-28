import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payroll_system/src/common/common.dart';

final appwriteProvider = Provider<Client>((ref) {
  final client = Client();
  client.setEndpoint(EnvModel.endpoint).setProject(EnvModel.project);
  return client;
});

final databaseProvider = Provider<Databases>((ref) {
  final client = ref.read(appwriteProvider);
  return Databases(client);
});

final accountProvider = Provider<Account>((ref) {
  final client = ref.read(appwriteProvider);
  return Account(client);
});
