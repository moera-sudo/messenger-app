import 'dart:developer';
import '../../../../entities/home/chat_view.dart';
import '../../domain/repos/home_interface.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: HomeInterface)
class HomeRepositoryMock implements HomeInterface {
  @override
  Future<List<ChatView>> getChats() async {
    log('📥 [HomeRepositoryMock] getChats() called');

    // имитация запроса
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();

    return [
      ChatView(
        id: 1,
        name: 'Test Chat 1',
        lastMessage: 'Hello!',
        updatedAt: now.subtract(const Duration(minutes: 3)),
        isUnread: true,
      ),
      ChatView(
        id: 2,
        name: 'Test Chat 2',
        lastMessage: 'How are you?',
        updatedAt: now.subtract(const Duration(hours: 1, minutes: 15)),
        isUnread: true,
      ),
      ChatView(
        id: 3,
        name: 'Project Group',
        lastMessage: 'Let’s push the update tonight',
        updatedAt: now.subtract(const Duration(days: 1, hours: 2)),
        isUnread: true,
      ),
      ChatView(
        id: 4,
        name: 'Test Chat 1',
        lastMessage: 'Hello!',
        updatedAt: now.subtract(const Duration(minutes: 3)),
        isUnread: true,
      ),
      ChatView(
        id: 5,
        name: 'Test Chat 2',
        lastMessage: 'How are you?',
        updatedAt: now.subtract(const Duration(hours: 1, minutes: 15)),
        isUnread: true,
      ),
      ChatView(
        id: 6,
        name: 'Project Group',
        lastMessage: 'Let’s push the update tonight',
        updatedAt: now.subtract(const Duration(days: 1, hours: 2)),
        isUnread: true,
      ),
      ChatView(
        id: 7,
        name: 'Test Chat 1',
        lastMessage: 'Hello!',
        updatedAt: now.subtract(const Duration(minutes: 3)),
        isUnread: true,
      ),
      ChatView(
        id: 8,
        name: 'Test Chat 2',
        lastMessage: 'How are you?',
        updatedAt: now.subtract(const Duration(hours: 1, minutes: 15)),
        isUnread: true,
      ),
      ChatView(
        id: 9,
        name: 'Project Group',
        lastMessage: 'Let’s push the update tonight',
        updatedAt: now.subtract(const Duration(days: 1, hours: 2)),
        isUnread: true,
      ),
      ChatView(
        id: 10,
        name: 'Test Chat 1',
        lastMessage: 'Hello!',
        updatedAt: now.subtract(const Duration(minutes: 3)),
        isUnread: true,
      ),
      ChatView(
        id: 11,
        name: 'Test Chat 2',
        lastMessage: 'How are you?',
        updatedAt: now.subtract(const Duration(hours: 1, minutes: 15)),
        isUnread: true,
      ),
      ChatView(
        id: 12,
        name: 'Project Group',
        lastMessage: 'Let’s push the update tonight',
        updatedAt: now.subtract(const Duration(days: 1, hours: 2)),
        isUnread: true,
      ),

    ];
  }

  @override
  Future<void> deleteChat() async {
    log('🗑️ [HomeRepositoryMock] deleteChat() called');
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
