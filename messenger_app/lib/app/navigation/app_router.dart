// lib/navigation/app_router.dart

import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart'; 
import '../app.dart';

import '../../features/chat_feature/chat_view.dart';

@lazySingleton
class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/chat/:chatId',
        builder: (context, state) {
          final chatId = state.pathParameters['chatId'];
          return ChatScreen(chatId: chatId!);
        })
    ],
  );
}