// lib/features/home/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../entities/home/chat_view.dart';
import '../bloc/home_bloc.dart';
import '../widgets/chat_tile.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      // Используем BlocBuilder для перерисовки UI в зависимости от состояния BLoC
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // Состояние загрузки
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(
              child: Text('Ошибка: ${state.message}'),
            );
          }

          if (state is HomeLoaded) {
            final chats = state.chats;
            if (chats.isEmpty) {
              return const Center(child: Text('У вас пока нет чатов'));
            }


            return ListView.separated(
              // Важный отступ снизу, чтобы список не перекрывался "островком" навигации
              padding: const EdgeInsets.only(bottom: 0, top: 0),
              itemCount: chats.length,
              separatorBuilder: (_, __) => Divider(
                color: theme.dividerColor.withAlpha(25), // Чуть менее заметный
                indent: 72,
                endIndent: 0,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ChatTile(
                  chat: chat,
                  onTap: () {
                    context.push('/chat/${chat.id}');
                  },
                );
              },
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
}