part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Событие для проверки статуса аутентификации (обычно при запуске приложения).
class AuthCheckStatusRequested extends AuthEvent {}

/// Событие, инициируемое нажатием на кнопку "Войти".
class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

/// Событие, инициируемое нажатием на кнопку "Зарегистрироваться".
class AuthRegisterRequested extends AuthEvent {
  final String username;
  final String name;
  final String password;

  const AuthRegisterRequested({
    required this.username,
    required this.name,
    required this.password,
  });

  @override
  List<Object> get props => [username, name, password];
}

/// Событие, инициируемое нажатием на кнопку "Выйти".
class AuthLogoutRequested extends AuthEvent {}