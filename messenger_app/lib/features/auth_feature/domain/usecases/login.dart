import 'package:injectable/injectable.dart';
import '../repos/auth_interface.dart';

@lazySingleton
class Login {
  final AuthInterface _repository;
  Login(this._repository);

  Future<void> call({required String username, required String password}) =>
      _repository.login(username: username, password: password);
}