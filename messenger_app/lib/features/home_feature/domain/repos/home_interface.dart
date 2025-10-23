import '../../../../entities/home/chat_view.dart';

abstract interface class HomeInterface {

  Future<List<ChatView>> getChats();

  Future<void> deleteChat();
}