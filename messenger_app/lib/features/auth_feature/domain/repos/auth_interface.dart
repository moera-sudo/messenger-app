abstract interface class AuthInterface {
  Future<void> login({required String username, required String password});
  Future<void> register({required String username, required String name, required String password});
  Future<void> logout();
  Future<String?> getToken(); // Получить токен для проверки статуса
}