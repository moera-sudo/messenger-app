part of 'home_bloc.dart';


abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние (пустой экран)
class HomeInitial extends HomeState {}

/// Идёт загрузка
class HomeLoading extends HomeState {}

/// Чаты успешно загружены
class HomeLoaded extends HomeState {
  final List<ChatView> chats;
  const HomeLoaded(this.chats);

  @override
  List<Object?> get props => [chats];
}

/// Произошла ошибка
class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
