import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../logger/logger.dart';

@lazySingleton
class SecureStorageClient {

  @protected
  final FlutterSecureStorage storage;

  @protected
  static const tokenKey = 'token';

  SecureStorageClient(this.storage);

  final _logger = AppLogger();



  Future<String?> getToken() async {
    _logger.info("Reading token from SecureStorage");
    try {
      final token = await storage.read(key: tokenKey);
      _logger.info("Token from storage is: ${token == null ? 'null' : 'found' + token}");
      return token;
    } catch (e) {
      _logger.error("Error reading from secure storage : $e");
      return null;
    }
  }

  Future<void> clearStorageForDebug() async {
    _logger.debug("Clearing all data from Secure Storage");
    await storage.deleteAll();
    _logger.debug("Secure Storage cleared");
  }


}