import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:layar_cerita_app/data/repository/auth_repository.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';

import '../../../data/source/network/request/login_body.dart';
import '../../../data/source/network/request/register_body.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  UIState _registerState = InitialState();

  UIState get registerState => _registerState;

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final obsecurePassword = ValueNotifier<bool>(true);

  String _registerName = '';
  String _registerEmail = '';
  String _registerPassword = '';

  RegisterProvider({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  void onNameChanged(String value) {
    _registerName = value;
    notifyListeners();
  }

  void onEmailChanged(String value) {
    _registerEmail = value;
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _registerPassword = value;
    notifyListeners();
  }

  void toggleObsecurePassword() {
    obsecurePassword.value = !obsecurePassword.value;
    notifyListeners();
    debugPrint("obsecurePassword: ${obsecurePassword.value}");
  }

  Future<void> register({required Function() onLoginSuccess}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    debugPrint("register");
    if (registerFormKey.currentState?.validate() == true) {
      registerFormKey.currentState?.save();
      notifyListeners();

      debugPrint("name: $_registerName");
      debugPrint("email: $_registerEmail");
      debugPrint("password: $_registerPassword");

      final registerBody = RegisterBody(
        email: _registerEmail,
        password: _registerPassword,
        name: _registerName,
      );
      try {
        _registerState = UIState.loading(message: "Mendaftarkan akun...");
        notifyListeners();
        await _authRepository.register(registerBody: registerBody);
        _registerState = UIState.success();
        notifyListeners();
        _login(onLoginSuccess);
      } catch (e) {
        _registerState = UIState.error(e.toString());
        notifyListeners();
      }
    }
  }

  Future<void> _login(Function() onLoginSuccess) async {
    debugPrint("login");
    final loginBody = LoginBody(
      email: _registerEmail,
      password: _registerPassword,
    );

    try {
      _registerState = UIState.loading(message: "Login...");
      notifyListeners();

      await _authRepository.login(loginBody: loginBody);
      _registerState = UIState.success();
      notifyListeners();
      onLoginSuccess.call();
    } catch (e) {
      _registerState = UIState.error(e.toString());
      notifyListeners();
    }
  }

  void resetState() {
    _registerState = InitialState();
    notifyListeners();
  }
}
