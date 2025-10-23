// lib/features/chat_feature/presentation/bloc/chat_state.dart
part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}
class ChatLoadInProgress extends ChatState {}

class ChatLoadSuccess extends ChatState {
  final List<MessageEntity> messages;
  const ChatLoadSuccess(this.messages);
  @override
  List<Object> get props => [messages];
}

class ChatLoadFailure extends ChatState {
  final String error;
  const ChatLoadFailure(this.error);
}