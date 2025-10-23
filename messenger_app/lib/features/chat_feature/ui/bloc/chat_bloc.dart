// lib/features/chat_feature/presentation/bloc/chat_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../entities/chat/chat_model.dart';
import '../../domain/repos/chat_interface.dart';
import '../../domain/usecases/get_messager.dart';
import '../../domain/usecases/send_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessages _getMessages;
  final SendMessage _sendMessage;
  final ChatInterface _repository; // Нужен для подписки на стрим
  
  late final String _chatId;
  StreamSubscription<MessageEntity>? _messagesSubscription;

  ChatBloc(this._getMessages, this._sendMessage, this._repository) : super(ChatInitial()) {
    on<ChatMessagesLoaded>(_onMessagesLoaded);
    on<ChatMessageSent>(_onMessageSent);
    on<_ChatMessageReceived>(_onMessageReceived);
  }

  Future<void> _onMessagesLoaded(ChatMessagesLoaded event, Emitter<ChatState> emit) async {
    emit(ChatLoadInProgress());
    _chatId = event.chatId;
    
    // Отписываемся от старого стрима, если он был
    await _messagesSubscription?.cancel();
    // Подписываемся на новый стрим сообщений
    _messagesSubscription = _repository.getMessagesStream(_chatId).listen(
          (message) => add(_ChatMessageReceived(message)),
        );

    try {
      final messages = await _getMessages(_chatId);
      emit(ChatLoadSuccess(messages));
    } catch (e) {
      emit(ChatLoadFailure(e.toString()));
    }
  }

  Future<void> _onMessageSent(ChatMessageSent event, Emitter<ChatState> emit) async {
    if (state is ChatLoadSuccess) {
      await _sendMessage(chatId: _chatId, text: event.text);
      // Мы не меняем state здесь, потому что новое сообщение придет
      // через StreamSubscription и обработается в _onMessageReceived.
      // Это имитирует real-time поведение.
    }
  }

  void _onMessageReceived(_ChatMessageReceived event, Emitter<ChatState> emit) {
    if (state is ChatLoadSuccess) {
      final currentState = state as ChatLoadSuccess;
      final updatedMessages = List<MessageEntity>.from(currentState.messages)..add(event.message);
      emit(ChatLoadSuccess(updatedMessages));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}