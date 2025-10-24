import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/check_auth_status.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthStatus _checkAuthStatus;
  final Login _login;
  final Register _register;
  final Logout _logout;

  AuthBloc(
    this._checkAuthStatus,
    this._login,
    this._register,
    this._logout,
  ) : super(AuthInitial()) {
    // Регистрируем обработчики для каждого события
    on<AuthCheckStatusRequested>(_onCheckStatus);
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
  }

  /// Обработчик проверки статуса аутентификации
  Future<void> _onCheckStatus(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    print("--- [BLOC] AuthCheckStatusRequested received. Starting check...");
    try {
      final token = await _checkAuthStatus();
      if (token != null) {
        // Если токен есть, пользователь аутентифицирован
        emit(AuthAuthenticated());
      } else {
        // Если токена нет, пользователь не аутентифицирован
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      // В случае любой ошибки (например, с Secure Storage) считаем, что пользователь не вошел
      emit(AuthUnauthenticated());
    }
  }

  /// Обработчик входа
  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Сразу переводим UI в состояние загрузки
    emit(AuthLoading());
    try {
      await _login(username: event.username, password: event.password);
      // Если usecase выполнился без ошибок, значит, токен получен и сохранен
      emit(AuthAuthenticated());
    } catch (e) {
      // Если usecase выбросил исключение (неверный пароль, нет сети), показываем ошибку
      emit(AuthFailure(e.toString()));
    }
  }

  /// Обработчик регистрации
  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _register(
        username: event.username,
        name: event.name,
        password: event.password,
      );
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  /// Обработчик выхода
  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _logout();
      // После успешного выхода переводим в состояние "не аутентифицирован"
      emit(AuthUnauthenticated());
    } catch (e) {
      // Эта операция не должна падать, но на всякий случай
      emit(AuthFailure("Logout failed: ${e.toString()}"));
    }
  }
}