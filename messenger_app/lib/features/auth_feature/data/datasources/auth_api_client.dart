import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/api/api_client.dart';
import '../../../../shared/logger/logger.dart';
import '../entities/auth_request_model.dart';
import '../entities/reg_request_model.dart';

@lazySingleton
class AuthApiClient {
  final ApiService _apiService;
  final AppLogger _logger;
  
  AuthApiClient(this._apiService, this._logger);

  // Геттер для удобства доступа к настроенному Dio
  Dio get _dio => _apiService.dio;

  Future<String> login(AuthRequestModel request) async {
    try {
      // Делаем POST-запрос на эндпоинт /auth/authenticate
      final response = await _dio.post(
        '/auth/authenticate', 
        data: request.toJson(), 
      );

      
      if (response.statusCode == 200 && response.data != null) {
        final token = response.data['token'];
        
        if (token != null) {
          return token;
        } else {
          throw Exception('Token not found in login response');
        }
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // DioException содержит детальную информацию об ошибке
      final errorMessage = e.response?.data?['message'] ?? e.message ?? 'Unknown login error';
      throw Exception(errorMessage);
    }
  }

  /// Выполняет регистрацию. В случае успеха ничего не возвращает.
  Future<void> register(RegRequestModel request) async {
    try {
      // Делаем POST-запрос на эндпоинт /auth/register
      final response = await _dio.post(
        '/auth/register',
        data: request.toJson(),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final successMessage = response.data['message'] as String?;

        if (successMessage != null){
          _logger.info("AUTH: Registration success $successMessage");
        } else {
          _logger.info("AUTH : Registration successful, but no message was returned");
        }
      } else {
        throw Exception('Registration failed with status: ${response.statusCode}');
      }

    } on DioException catch (e) {
      // Если бэкенд вернул ошибку (например, 409 Conflict - user already exists),
      // мы извлекаем сообщение из ответа.
      final errorMessage = e.response?.data?['message'] ?? e.message ?? 'Unknown registration error';
      _logger.error("AUTH: REG ERROR: $errorMessage");
      throw Exception(errorMessage);
    }
  }
}