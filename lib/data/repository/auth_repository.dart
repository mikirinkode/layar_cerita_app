import 'package:layar_cerita_app/data/source/network/api_config.dart';
import 'package:layar_cerita_app/data/source/network/remote_data_source.dart';

import '../source/local/shared_preferences_service.dart';
import '../source/network/api_handler.dart';
import '../source/network/request/login_body.dart';
import '../source/network/request/register_body.dart';

class AuthRepository {
  final SharedPreferencesService _sharedPreferencesService;
  final RemoteDataSource _remoteDataSource;

  AuthRepository({
    required SharedPreferencesService sharedPreferencesService,
    required RemoteDataSource remoteDataSource,
  })  : _sharedPreferencesService = sharedPreferencesService,
        _remoteDataSource = remoteDataSource;

  Future<void> register({required RegisterBody registerBody}) async {
    try {
      final result =
          await _remoteDataSource.register(registerBody: registerBody);
      if (result.error == true) {
        return Future.error(result.message);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> login({required LoginBody loginBody}) async {
    try {
      final result = await _remoteDataSource.login(loginBody: loginBody);
      if (result.error == true) {
        return Future.error(result.message);
      }
      await _sharedPreferencesService.setToken(result.loginResult.token);
      await _sharedPreferencesService.setIsLoggedIn(true);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> getIsLoggedIn() {
    return _sharedPreferencesService.getIsLoggedIn();
  }
}
