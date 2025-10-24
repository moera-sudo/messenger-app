import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module 
abstract class RegisterModule {
  
  @lazySingleton 
  Dio get dio => Dio(); 

  @lazySingleton // Регистрируем FlutterSecureStorage как синглтон
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}