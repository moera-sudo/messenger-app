// lib/features/chat_feature/domain/usecases/send_message.dart
import 'package:injectable/injectable.dart';
import '../repos/chat_interface.dart';


@lazySingleton
class SendMessage {
  final ChatInterface _repository;
  SendMessage(this._repository);

  Future<void> call({required String chatId, required String text}) =>
      _repository.sendMessage(chatId, text);
}