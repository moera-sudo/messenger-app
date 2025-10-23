// lib/DI/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Вот тот самый импорт. Сначала будет ошибка, это нормально!
// Она исчезнет после Шага 4.
import 'service_locator.config.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> setupServiceLocator() async => sl.init();