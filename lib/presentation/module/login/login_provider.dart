import 'package:flutter/foundation.dart';
import 'package:layar_cerita_app/data/repository/auth_repository.dart';

class LoginProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginProvider({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;
}
