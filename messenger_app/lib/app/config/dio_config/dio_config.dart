import 'package:dio/dio.dart';
import '../consts.dart';

class DioConfig extends BaseOptions{
  DioConfig() : super (
    baseUrl: Consts.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Content-Type' : 'application/json'}
  );
}