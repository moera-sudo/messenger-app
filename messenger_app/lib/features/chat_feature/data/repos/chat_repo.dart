// lib/features/chat_feature/data/repos/chat_repo_impl.dart
import 'dart:async';
import 'package:injectable/injectable.dart';
import '../../../../entities/chat/chat_model.dart';
import '../../domain/repos/chat_interface.dart';
import 'package:hive_flutter/hive_flutter.dart';


@LazySingleton(as: ChatInterface)
class ChatRepository implements ChatInterface {
  final _controller = StreamController<MessageEntity>.broadcast();
  static const String _boxName = 'chat_history_maps_v4'; // Новое имя, чтобы избежать конфликтов со старой базой

    Future<Box<List>> _getChatHistoryBox() async {
      return await Hive.openBox<List>(_boxName);
    }

    @override
    Future<List<MessageEntity>> getMessages(String chatId) async {
      final box = await _getChatHistoryBox();
      final messagesJson = box.get(chatId);

      if (messagesJson == null || messagesJson.isEmpty) {
        print("--- [REPO] No messages found in Hive. Returning empty list. ---");
        return []; 
      }

      print(messagesJson);
      // Преобразуем List<dynamic> (из Map'ов) в List<MessageEntity>
      final messages = messagesJson
          .map((item) => MessageEntity.fromJson(Map<String, dynamic>.from(item))) 
          .toList();
          
      return messages;
    }

    @override
    Future<void> sendMessage(String chatId, String text) async {
      final box = await _getChatHistoryBox();
      print("--- [REPO_WRITE] Saving message to chatId: '$chatId' ---");

      
      final newMessage = MessageEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        senderId: 'my_id',
        sentAt: DateTime.now(),
      );

      final currentMessagesDynamic = box.get(chatId, defaultValue: [])!;
      

      final currentMessagesJson = currentMessagesDynamic.map((item) => Map<String, dynamic>.from(item)).toList();

      currentMessagesJson.add(newMessage.toJson());

      // Сохраняем обновленный список Map'ов обратно в бокс
      await box.put(chatId, currentMessagesJson);

      _controller.add(newMessage);
    }
    
    @override
    Stream<MessageEntity> getMessagesStream(String chatId) {
      return _controller.stream;
    }
  }