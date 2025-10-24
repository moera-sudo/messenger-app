import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../entities/auth_request_model.dart';
import '../entities/reg_request_model.dart';

@lazySingleton
class AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  Future<String> login(AuthRequestModel request) async {
    // Имитация запроса к API
    await Future.delayed(const Duration(seconds: 1));
    if (request.username == 'test' && request.password == 'test') {
      // Имитация успешного ответа с фейковым токеном
      return 'fake_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
    } else {
      // Имитация ошибки
      throw Exception('Invalid credentials');
    }
  }

  Future<String> register(RegRequestModel request) async {
    await Future.delayed(const Duration(seconds: 1));
    // Всегда успешная регистрация в моке
    return 'fake_jwt_token_for_new_user_${DateTime.now().millisecondsSinceEpoch}';
  }
}