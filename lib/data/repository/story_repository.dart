import '../source/local/shared_preferences_service.dart';
import '../source/network/remote_data_source.dart';
import '../source/network/response/story/story_detail_response.dart';
import '../source/network/response/story/story_list_response.dart';

class StoryRepository {
  final SharedPreferencesService _sharedPreferencesService;
  final RemoteDataSource _remoteDataSource;

  StoryRepository({
    required SharedPreferencesService sharedPreferencesService,
    required RemoteDataSource remoteDataSource,
  })  : _sharedPreferencesService = sharedPreferencesService,
        _remoteDataSource = remoteDataSource;

  Future<StoryListResponse> getStoryList() async {
    final token = await _sharedPreferencesService.getToken();
    try {
      if (token == null){
        return Future.error("Unauthorized"); // TODO
      } else {
        return await _remoteDataSource.getStoryList(token);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<StoryDetailResponse> getStoryDetail(String storyId) async {
    final token = await _sharedPreferencesService.getToken();
    try {
      if (token == null){
        return Future.error("Unauthorized"); // TODO
      } else {
        return await _remoteDataSource.getStoryDetail(token, storyId);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
