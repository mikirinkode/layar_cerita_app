import '../source/local/shared_preferences_service.dart';

class UserRepository {
  
  final SharedPreferencesService _sharedPreferencesService;

  UserRepository(this._sharedPreferencesService);

  Future<String?> getUserName() async {
    return await _sharedPreferencesService.getUserName();
  }
}