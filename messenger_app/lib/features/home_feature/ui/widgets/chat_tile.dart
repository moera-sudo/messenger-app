import 'package:flutter/material.dart';
import '../../../../entities/home/chat_view.dart';

class ChatTile extends StatelessWidget {
  final ChatView chat;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final time = TimeOfDay.fromDateTime(chat.updatedAt);

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: NetworkImage("https://picsum.photos/200"),
        radius: 26,
      ),
      title: Text(
        chat.name,
        style: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        chat.lastMessage,
        style: theme.textTheme.bodySmall!.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          if (chat.isUnread)
            Container(
              // margin: const EdgeInsets.only(bottom: 12, top: 12),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
