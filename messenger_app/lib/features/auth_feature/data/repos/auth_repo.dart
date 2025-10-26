import 'package:injectable/injectable.dart';
import '../../domain/repos/auth_interface.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_api_client.dart';
import '../entities/auth_request_model.dart';
import '../entities/reg_request_model.dart';

import '../../../../shared/logger/logger.dart';

@LazySingleton(as: AuthInterface)
class AuthRepository implements AuthInterface {
  final AuthApiClient _authApiClient;
  final AuthLocalDataSource _localDataSource;
  final AppLogger _logger;

  AuthRepository(this._authApiClient, this._localDataSource, this._logger);

  @override
  Future<String?> getToken() {
    _logger.info("getToken called.");

    return _localDataSource.getToken();
  }
  
  @override
  Future<void> login({required String username, required String password}) async {
    _logger.info("Login attempt for user $username");
    final request = AuthRequestModel(username: username, password: password);
    final token = await _authApiClient.login(request);
    await _localDataSource.saveToken(token);
    _logger.info("Token saved");
  }

  @override
  Future<void> logout() {
    _logger.info("Logout attempt");
    return _localDataSource.deleteToken();
  } 

  @override
  Future<void> register({required String username, required String name, required String password}) async {
    _logger.info("Reg attempt for user $username");
    final request = RegRequestModel(username: username, name: name, password: password);
    await _authApiClient.register(request);
    _logger.info("Reg completed");
  }
}