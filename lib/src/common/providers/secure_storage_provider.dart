import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

@riverpod
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage();
}

@riverpod
Future<String?> readSession(ReadSessionRef ref) async {
  final secureStorage = ref.read(secureStorageProvider);
  return await secureStorage.read(key: 'session');
}
