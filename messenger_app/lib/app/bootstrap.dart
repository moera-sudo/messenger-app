import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:messenger_app/shared/api/api_client.dart';

import 'lifespan.dart';

import '../features/auth_feature/auth_view.dart';

import '../shared/logger/logger.dart';


import 'app.dart';
import 'DI/service_locator.dart';


Future<void> bootstrap() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp,]
  );

  await setupServiceLocator();

  final logger = AppLogger();


  if (kDebugMode) {
    final authLocalDataSource = sl<AuthLocalDataSource>();

    await authLocalDataSource.clearStorageForDebug();
    
    final apiService = sl<ApiService>();

    apiService.pingServer();
  }


  WidgetsBinding.instance.addObserver(Lifespan(logger));

  

  runApp(const MainApp()); 
} 