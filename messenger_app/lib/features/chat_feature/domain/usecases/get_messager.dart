// lib/features/chat_feature/domain/usecases/get_messages.dart
import 'package:injectable/injectable.dart';
import '../../../../entities/chat/chat_model.dart';
import '../repos/chat_interface.dart';

@lazySingleton
class GetMessages {
  final ChatInterface _repository;
  GetMessages(this._repository);

  Future<List<MessageEntity>> call(String chatId) => _repository.getMessages(chatId);
}