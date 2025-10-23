import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


import 'app.dart';
import 'DI/service_locator.dart';


Future<void> bootstrap() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp,]
  );

  await setupServiceLocator();
  

  runApp(const MainApp()); 
} 