// lib/features/chat_feature/presentation/bloc/chat_event.dart
part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object> get props => [];
}

// Загрузить первоначальные сообщения
class ChatMessagesLoaded extends ChatEvent {
  final String chatId;
  const ChatMessagesLoaded(this.chatId);
}

// Отправить новое сообщение
class ChatMessageSent extends ChatEvent {
  final String text;
  const ChatMessageSent(this.text);
}

// Внутреннее событие, когда приходит новое сообщение по стриму
class _ChatMessageReceived extends ChatEvent {
  final MessageEntity message;
  const _ChatMessageReceived(this.message);
}