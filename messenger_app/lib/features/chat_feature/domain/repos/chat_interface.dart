import '../../../../entities/chat/chat_model.dart';

abstract interface class ChatInterface {
  // Получить все сообщения для конкретного чата
  Future<List<MessageEntity>> getMessages(String chatId);

  // Отправить сообщение
  Future<void> sendMessage(String chatId, String text);
  
  // Слушать новые сообщения (для real-time обновлений)
  Stream<MessageEntity> getMessagesStream(String chatId);
}