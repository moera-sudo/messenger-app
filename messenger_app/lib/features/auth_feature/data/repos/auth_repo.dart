// lib/features/auth_feature/data/repos/auth_repo_impl.dart
import 'package:injectable/injectable.dart';
import '../../domain/repos/auth_interface.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../entities/auth_request_model.dart';
import '../entities/reg_request_model.dart';

@LazySingleton(as: AuthInterface)
class AuthRepositoryImpl implements AuthInterface {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<String?> getToken() {
    print("--- [REPO] getToken called.");
    return _localDataSource.getToken();
  }
  
  @override
  Future<void> login({required String username, required String password}) async {
    final request = AuthRequestModel(username: username, password: password);
    final token = await _remoteDataSource.login(request);
    await _localDataSource.saveToken(token);
  }

  @override
  Future<void> logout() => _localDataSource.deleteToken();

  @override
  Future<void> register({required String username, required String name, required String password}) async {
    final request = RegRequestModel(username: username, name: name, password: password);
    final token = await _remoteDataSource.register(request);
    await _localDataSource.saveToken(token);
  }
}