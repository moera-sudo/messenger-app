
import 'package:flutter/material.dart';
import '../../../../../entities/chat/chat_model.dart';


class MessageBubble extends StatelessWidget {
  final MessageEntity message;
  const MessageBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    // Определяем, наше это сообщение или собеседника
    final isMyMessage = message.senderId == 'my_id';
    final alignment = isMyMessage ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = isMyMessage
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondaryContainer;
    final textColor = isMyMessage
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondaryContainer;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
