import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthLocalDataSource {
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'access_token';

  AuthLocalDataSource(this._storage);

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    print("--- [DATASOURCE] Reading token from Secure Storage...");
    try {
      final token = await _storage.read(key: _tokenKey);
      print("--- [DATASOURCE] Token from storage is: ${token == null ? 'null' : 'found'}");
      return token;
    } catch (e) {
      print("--- [DATASOURCE] ERROR reading from Secure Storage: $e");
      return null;
    }
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<void> clearStorageForDebug() async {
    print("--- [DEBUG] Clearing all data from Secure Storage... ---");
    await _storage.deleteAll();
    print("--- [DEBUG] Secure Storage cleared. ---");
  }
}