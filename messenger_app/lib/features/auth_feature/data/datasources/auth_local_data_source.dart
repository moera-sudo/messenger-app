import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/local_source/secure_storage_client.dart';

@lazySingleton
class AuthLocalDataSource extends SecureStorageClient{

  AuthLocalDataSource(super.storage);

  Future<void> saveToken(String token) async {
    await storage.write(key: SecureStorageClient.tokenKey, value: token);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: SecureStorageClient.tokenKey); //TODO ПЕРЕНЕСТИ В ФИЧУ PROFILE/LOGOUT
  }

}