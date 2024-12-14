import 'package:layar_cerita_app/data/repository/auth_repository.dart';
import 'package:layar_cerita_app/data/repository/story_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/source/local/shared_preferences_service.dart';
import '../data/source/network/remote_data_source.dart';

class Injection {
  static Injection? _instance;

  static AuthRepository? _authRepository;
  static StoryRepository? _storyRepository;

  Injection._internal() {
    _instance = this;
  }

  static Injection get instance => _instance ??= Injection._internal();

  Future<Injection> initialize() async {
    final remoteDataSource = RemoteDataSource();
    final sharedPreferences = await SharedPreferences.getInstance();

    final sharedPreferencesService = SharedPreferencesService(
      preferences: sharedPreferences,
    );

    _authRepository = AuthRepository(
      sharedPreferencesService: sharedPreferencesService,
      remoteDataSource: remoteDataSource,
    );

    _storyRepository = StoryRepository(
      sharedPreferencesService: sharedPreferencesService,
      remoteDataSource: remoteDataSource,
    );

    return this;
  }

  AuthRepository get authRepository => _authRepository!;

  StoryRepository get storyRepository => _storyRepository!;
}
