import 'package:logger/logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppLogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 80,
      colors: true,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, 
    ));

    void trace(String message) => _logger.t(message); // Трассировка - для максимально подробного логгирования
    void debug(String message) => _logger.d(message); // Дебаг - для логгирования в дебагинге
    void info(String message) => _logger.i(message); // Инфо - Для логгирования информации
    void warning(String message) => _logger.w(message); // Warning - для вывода предупреждения
    void error(String message, [dynamic error, StackTrace? stackTrace]) => _logger.e(message, error: error, stackTrace: stackTrace); // Для вывода ошибки
    void fuck(String message) => _logger.f(message); // Для вывода критической ошибки 

    Future<void> close() => _logger.close();

}