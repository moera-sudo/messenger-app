import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../app.dart';
import '../DI/service_locator.dart';

import '../../shared/widgets/Placeholder/placeholder_screen.dart';
import '../../features/chat_feature/chat_view.dart';
import '../../features/auth_feature/auth_view.dart';

@lazySingleton
class AppRouter {
  // final AuthBloc authBloc; // <-- Убираем поле

  late final GoRouter router;

  // AppRouter(this.authBloc) { // <-- Убираем BLoC из конструктора
  AppRouter() { 
    router = GoRouter(
      initialLocation: '/',
      // Теперь, когда AuthBloc - синглтон, мы можем безопасно получить его из sl.
      refreshListenable: GoRouterRefreshStream(sl<AuthBloc>().stream),
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const PlaceholderScreen(title: 'Progress..', icon: Icons.circle),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const MainScreen(),
        ),
        // ... другие ваши роуты
         GoRoute(
            path: '/login',
            builder: (context, state) => const AuthScreen(),
          ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        // Используем context.read<AuthBloc>() - это самый правильный способ
        // получить BLoC внутри redirect, так как он гарантированно
        // возьмет экземпляр из BlocProvider'а над MaterialApp.
        final authState = context.read<AuthBloc>().state;
        
        // ... остальная логика redirect остается без изменений ...
        if (authState is AuthInitial) {
          return state.uri.toString() == '/splash' ? null : '/splash';
        }

        final isLoggedIn = authState is AuthAuthenticated;
        final isLoggingIn = state.uri.toString() == '/login';
        
        if (!isLoggedIn && !isLoggingIn) {
          return '/login';
        }
        
        if (isLoggedIn && (isLoggingIn || state.uri.toString() == '/splash')) {
          return '/';
        }

        return null;
      },
    );
  }
}

// Вспомогательный класс GoRouterRefreshStream остается без изменений
class GoRouterRefreshStream extends ChangeNotifier {
    GoRouterRefreshStream(Stream<dynamic> stream) {
        notifyListeners();
        stream.asBroadcastStream().listen((_) => notifyListeners());
    }
}