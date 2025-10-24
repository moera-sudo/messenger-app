import 'package:injectable/injectable.dart';
import '../repos/auth_interface.dart';

@lazySingleton
class CheckAuthStatus {
  final AuthInterface _repository;
  CheckAuthStatus(this._repository);

  Future<String?> call() {
    print("--- [USECASE] CheckAuthStatus called.");
    return _repository.getToken();
  }

}