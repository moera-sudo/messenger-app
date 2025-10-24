import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/DI/service_locator.dart';
import '../bloc/chat_bloc.dart';

import '../widgets/message_input/message_input.dart';
import '../widgets/message_bubble/message_bubble.dart';





class ChatScreen extends StatelessWidget {
  final String chatId;
  const ChatScreen({required this.chatId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatBloc>()..add(ChatMessagesLoaded(chatId)),
      child: Scaffold(
        appBar: AppBar(title: Text('Chat with ID: $chatId')),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoadInProgress || state is ChatInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ChatLoadSuccess) {
                      
                      return ListView.builder(
                        reverse: true, // Чаты обычно идут снизу вверх
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          // Так как reverse=true, сообщения нужно "перевернуть"
                          final message = state.messages[state.messages.length - 1 - index];
                          return MessageBubble(message: message);
                        },
                      );
                    }
                    if (state is ChatLoadFailure) {
                      return Center(child: Text('Error: ${state.error}'));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            MessageInput(),
          ],
        ),
      ),
    );
  }
}