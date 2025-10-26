import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../app/DI/service_locator.dart';
import '../../app/config/dio_config/dio_config.dart';
import '../../app/config/consts.dart';
import '../logger/logger.dart';
import '../local_source/secure_storage_client.dart';


import '../../features/auth_feature/auth_view.dart';


@lazySingleton
class ApiService {
    final Dio _dio;
    final SecureStorageClient _secureStorageClient;
    final AppLogger _logger;

    StompClient? _stompClient;



    ApiService(this._dio, this._secureStorageClient, this._logger) {
        _dio.options = DioConfig();

        _dio.interceptors.add(_createInterceptors());
    }

    Dio get dio => _dio;

    Stream<StompFrame> subscribeToChatTopic(String chatId){

        final config = StompConfig(
            url: Consts.stompUrl,
            onConnect: _onStompConnect,
            onWebSocketError: (dynamic error) => _logger.error("WS ERROR: $error"),
            stompConnectHeaders: {},
            webSocketConnectHeaders: {}
        );

        _stompClient = StompClient(config: config)..activate();
    
    
            // Возвращаем стрим для конкретной подписки
            // `stompClient.subscribe` возвращает функцию для отписки, а не стрим.
            // Поэтому мы должны создать свой собственный StreamController.
        final streamController = StreamController<StompFrame>.broadcast();

        _stompClient?.subscribe(
            destination: '/topic/chat/$chatId', // <-- Адрес, на который подписываемся
            callback: (frame) {
                // Когда приходит сообщение, добавляем его в наш стрим
                streamController.add(frame);
            },
            );

            return streamController.stream;
        }

        /// Отправляет сообщение на сервер через STOMP
        void sendChatMessage(String chatId, String messageText) {
            _stompClient?.send(
            destination: '/app/chat/$chatId/sendMessage', // <-- Адрес, куда отправляем
            body: messageText, // Тело сообщения (может быть JSON в виде строки)
            );
        }

        /// Отключает STOMP-клиент
        void deactivateStomp() {
            _stompClient?.deactivate();
            _stompClient = null;
        }

        // Callback, который вызывается при успешном подключении к STOMP
        void _onStompConnect(StompFrame frame) {
            _logger.info("STOMP: Succesfully connected to broker! ");
            // Здесь можно выполнить какие-то действия после подключения, 
            // например, подписаться на общий топик уведомлений.
        }


    Future<void> pingServer() async {
        _logger.info("Attempt to ping server on debug startup");

        try{
            final response = await _dio.get('/ping');

            if (response.statusCode == 200 && response.data != null){
                final Map<String, dynamic> responseData = response.data;

                final status = responseData['status'];
                final time = responseData['time'];

                _logger.info("PONG: STATUS - $status TIME - $time");
            } else {
                _logger.error("Failed to ping server with status code: ${response.statusCode}. Please check the server connection");
            }
        } on DioException catch (e){
            _logger.error("Failed to ping server with exception: $e Please check the server connection");
        }
    }    

    QueuedInterceptorsWrapper _createInterceptors() {
    
    return QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
            // Для незащищенных эндпоинтов (логин/регистрация) токен не нужен.
            // Мы можем добавить проверку, если потребуется.
            // final isPublicPath = options.path == '/auth/login' || options.path == '/auth/register';
            
            final token = await _secureStorageClient.getToken();
            if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
            }
            
            _logger.info("API Request: ${options.method} ${options.uri}");
            return handler.next(options);
            
        },
            
        onError: (DioException e, handler) async {
            _logger.error("API Error: ${e.response?.statusCode} ${e.requestOptions.uri}");
            // Централизованная обработка ошибки 401 (Не авторизован)
            if (e.response?.statusCode == 401) {
                _logger.warning("API Unauthorized request. Logging out..");
                sl<AuthBloc>().add(AuthLogoutRequested());
            }
        
            return handler.next(e);
        },
        onResponse: (response, handler) {
            _logger.info("API Response:${response.statusCode} ");
            return handler.next(response);
        },
    );
    }

    // TODO Сделать апи клиент и авторизацию с чатами. 

}