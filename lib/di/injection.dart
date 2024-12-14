import 'package:layar_cerita_app/data/repository/auth_repository.dart';
import 'package:layar_cerita_app/data/repository/story_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/source/local/shared_preferences_service.dart';
import '../data/source/network/remote_data_source.dart';

class Injection {
  static Injection? _instance;

  static AuthRepository? _authRepository;
  static StoryRepository? _restaurantRepository;

  static SharedPreferencesService? _sharedPreferencesService;

  Injection._internal() {
    _instance = this;
  }

  static Injection get instance => _instance ??= Injection._internal();

  Future<Injection> initialize() async {
    final remoteDataSource = RemoteDataSource();
    final sharedPreferences = await SharedPreferences.getInstance();

    _sharedPreferencesService = SharedPreferencesService(
      preferences: sharedPreferences,
    );

    _authRepository = AuthRepository(
      sharedPreferencesService: _sharedPreferencesService!,
      remoteDataSource: remoteDataSource,
    );

    _restaurantRepository = StoryRepository(
      sharedPreferencesService: _sharedPreferencesService!,
      remoteDataSource: remoteDataSource,
    );

    return this;
  }

  AuthRepository get authRepository => _authRepository!;

  StoryRepository get restaurantRepository => _restaurantRepository!;

  SharedPreferencesService get sharedPreferencesService =>
      _sharedPreferencesService!;
}
