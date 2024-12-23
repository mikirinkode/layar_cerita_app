import 'package:layar_cerita_app/data/source/network/response/auth/login_response.dart';
import 'package:layar_cerita_app/data/source/network/response/auth/register_response.dart';
import 'package:layar_cerita_app/data/source/network/response/story/story_list_response.dart';

import 'api_config.dart';
import 'api_handler.dart';
import 'request/login_body.dart';
import 'request/register_body.dart';
import 'response/story/add_story_response.dart';
import 'response/story/story_detail_response.dart';

class RemoteDataSource {
  Future<RegisterResponse> register(
      {required RegisterBody registerBody}) async {
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

  Future<StoryListResponse> getStoryList(String token) async {
    return await ApiHandler.get(
      url: Endpoints.stories,
      headers: ApiConfig.getHeadersWithAuth(token),
      fromJson: (json) => StoryListResponse.fromJson(json),
      errorMessage: 'Failed to get story list',
    );
  }

  
  Future<StoryListResponse> getPaginationStory(String token, int page, int size) async {
    return await ApiHandler.get(
      url: Endpoints.getPaginationStoryURL(page, size),
      headers: ApiConfig.getHeadersWithAuth(token),
      fromJson: (json) => StoryListResponse.fromJson(json),
      errorMessage: 'Failed to get story list',
    );
  }

  Future<StoryDetailResponse> getStoryDetail(
      String token, String storyId) async {
    return await ApiHandler.get(
      url: Endpoints.getDetailStoryURL(storyId),
      headers: ApiConfig.getHeadersWithAuth(token),
      fromJson: (json) => StoryDetailResponse.fromJson(json),
      errorMessage: 'Failed to get story detail',
    );
  }

  Future<AddStoryResponse> addStory({
    required String token,
    required List<int> bytes,
    required String filename,
    required Map<String, String> body,
  }) async {
    return await ApiHandler.postWithImage(
      url: Endpoints.stories,
      bytes: bytes,
      filename: filename,
      headers: ApiConfig.getFileUploadHeader(token),
      body: body,
      fromJson: (json) => AddStoryResponse.fromJson(json),
      errorMessage: 'Failed to add story',
    );
  }
}
