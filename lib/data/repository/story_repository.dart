import 'package:layar_cerita_app/data/source/network/response/story/add_story_response.dart';

import '../source/local/shared_preferences_service.dart';
import '../source/network/remote_data_source.dart';
import '../source/network/request/add_story_body.dart';
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
      if (token == null) {
        return Future.error("Unauthorized"); // TODO
      } else {
        return await _remoteDataSource.getStoryList(token);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

    Future<StoryListResponse> getPaginationStory(int page, int size) async {
    final token = await _sharedPreferencesService.getToken();
    try {
      if (token == null) {
        return Future.error("Unauthorized"); // TODO
      } else {
        return await _remoteDataSource.getPaginationStory(token, page, size);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<StoryDetailResponse> getStoryDetail(String storyId) async {
    final token = await _sharedPreferencesService.getToken();
    try {
      if (token == null) {
        return Future.error("Unauthorized"); // TODO
      } else {
        return await _remoteDataSource.getStoryDetail(token, storyId);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<AddStoryResponse> addStory({
    required List<int> bytes,
    required String filename,
    required AddStoryBody addStorybody,
  }) async {
    final token = await _sharedPreferencesService.getToken();
    final body = addStorybody.toJson();
    try {
      if (token == null) {
        return Future.error("Unauthorized"); // TODO
      } else {
        return await _remoteDataSource.addStory(
          token: token,
          bytes: bytes,
          filename: filename,
          body: body,
        );
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
