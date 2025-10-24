import 'package:injectable/injectable.dart';
import '../repos/auth_interface.dart';

@lazySingleton
class Register {
  final AuthInterface _repository;
  Register(this._repository);

  Future<void> call({required String username, required String name, required String password}) => 
      _repository.register(username: username, name: name, password: password);
}