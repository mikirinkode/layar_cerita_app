import 'package:layar_cerita_app/data/source/network/response/api_response.dart';
import 'package:layar_cerita_app/data/source/network/response/login_response.dart';
import 'package:layar_cerita_app/data/source/network/response/register_response.dart';

import 'api_config.dart';
import 'api_handler.dart';
import 'request/login_body.dart';
import 'request/register_body.dart';

class RemoteDataSource {
  Future<RegisterResponse> register({required RegisterBody registerBody}) async {
    final body = registerBody.toJson();
    return await ApiHandler.post(
      url: Endpoints.register,
      headers: ApiConfig.headers,
      body: body,
      fromJson: (json) => RegisterResponse.fromJson(json),
      errorMessage: 'Failed to register user',
    );
  }

  Future<LoginResponse> login({required LoginBody loginBody}) async {
    final body = loginBody.toJson();
    return await ApiHandler.post(
      url: Endpoints.login,
      headers: ApiConfig.headers,
      body: body,
      fromJson: (json) => LoginResponse.fromJson(json),
      errorMessage: 'Failed to login user',
    );
  }
}