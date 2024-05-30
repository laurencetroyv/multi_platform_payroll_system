import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
Future<String?> readSession(ReadSessionRef ref) async {
  final secureStorage = ref.read(secureStorageProvider);
  return await secureStorage.read(key: 'session');
}

@Riverpod(keepAlive: true)
Future<void> setSession(SetSessionRef ref, String key, String value) async {
  final secureStorage = ref.read(secureStorageProvider);
  await secureStorage.write(key: key, value: value);
}

@Riverpod(keepAlive: true)
Future<void> deleteSession(DeleteSessionRef ref, String key) async {
  final secureStorage = ref.read(secureStorageProvider);
  await secureStorage.delete(key: key);
}
