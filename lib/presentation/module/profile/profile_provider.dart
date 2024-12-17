
import 'package:flutter/foundation.dart';
import 'package:layar_cerita_app/data/repository/auth_repository.dart';
import 'package:layar_cerita_app/data/repository/user_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  String _userName = "UserName";

  String get userName => _userName;

  ProfileProvider(
      {required UserRepository userRepository,
      required AuthRepository authRepository})
      : _userRepository = userRepository,
        _authRepository = authRepository;

  Future<void> getUserName() async {
    _userName = await _userRepository.getUserName() ?? "UserName";
    notifyListeners();
  }

  Future<void> logout({required Function() onSuccess}) async {
    try {
      await _authRepository.logout();
      onSuccess.call();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
