part of 'home_bloc.dart';


abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}


class HomeLoadChats extends HomeEvent {}


class HomeRefreshChats extends HomeEvent {}


class HomeDeleteChat extends HomeEvent {
  final int chatId;
  const HomeDeleteChat(this.chatId);

  @override
  List<Object?> get props => [chatId];
}
