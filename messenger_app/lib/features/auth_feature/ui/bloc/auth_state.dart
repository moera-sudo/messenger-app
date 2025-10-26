part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние. BLoC еще не проверял, есть ли токен.
/// UI в этом состоянии может показывать splash screen или индикатор загрузки.
class AuthInitial extends AuthState {}

/// Идет асинхронная операция (проверка токена, логин или регистрация).
/// UI должен показывать индикатор загрузки, блокируя кнопки.
class AuthLoading extends AuthState {}

/// Пользователь успешно аутентифицирован.
/// Роутер перенаправит на главный экран.
class AuthAuthenticated extends AuthState {}

/// Пользователь не аутентифицирован (токена нет или он невалидный).
/// Роутер перенаправит на экран входа.
class AuthUnauthenticated extends AuthState {}

/// Произошла ошибка во время логина или регистрации.
/// UI должен показать сообщение об ошибке (например, в SnackBar).
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// UI может показать SnackBar "Success!" и, например, переключить форму обратно в режим логина.
class AuthRegisterSuccess extends AuthState {}