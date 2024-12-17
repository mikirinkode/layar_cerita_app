import 'package:flutter/widgets.dart';
import 'package:layar_cerita_app/data/repository/auth_repository.dart';

import '../../../data/source/network/request/login_body.dart';
import '../../../utils/ui_state.dart';

class LoginProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  UIState _loginState = InitialState();

  UIState get loginState => _loginState;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final obsecurePassword = ValueNotifier<bool>(true);

  String _loginEmail = '';
  String _loginPassword = '';

  LoginProvider({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  void onEmailChanged(String value) {
    _loginEmail = value;
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _loginPassword = value;
    notifyListeners();
  }

  void toggleObsecurePassword() {
    obsecurePassword.value = !obsecurePassword.value;
    notifyListeners();
    debugPrint("obsecurePassword: ${obsecurePassword.value}");
  }

  Future<void> login({required Function() onLoginSuccess}) async {
    debugPrint("login");
    final loginBody = LoginBody(
      email: _loginEmail,
      password: _loginPassword,
    );

    try {
      _loginState = UIState.loading(message: "Login...");
      notifyListeners();

      await _authRepository.login(loginBody: loginBody);
      _loginState = UIState.success();
      notifyListeners();
      onLoginSuccess.call();
    } catch (e) {
      _loginState = UIState.error(e.toString());
      notifyListeners();
    }
  }

    void resetState() {
    _loginState = InitialState();
    notifyListeners();
  }
}
