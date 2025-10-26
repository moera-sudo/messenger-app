import 'package:flutter/material.dart';

import '../shared/logger/logger.dart';

class Lifespan extends WidgetsBindingObserver{
  final AppLogger _logger;

  Lifespan(this._logger);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _logger.warning("Logger connection is closing...");
      _logger.close();
    }
  }
}

