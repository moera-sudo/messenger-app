import 'package:injectable/injectable.dart';
import '../repos/auth_interface.dart';

@lazySingleton
class Logout {
  final AuthInterface _repository;
  Logout(this._repository);

  Future<void> call() => _repository.logout();

}