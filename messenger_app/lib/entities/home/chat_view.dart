
class ChatView {
  final int id;
  final String name;
  final String lastMessage;
  final bool isUnread;
  final DateTime updatedAt;

  ChatView({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.isUnread,
    required this.updatedAt
  });
}