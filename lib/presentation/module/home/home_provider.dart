import 'package:flutter/foundation.dart';
import 'package:layar_cerita_app/data/repository/story_repository.dart';
import 'package:layar_cerita_app/data/source/network/response/story/story_response.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';

class HomeProvider extends ChangeNotifier {
  final StoryRepository _storyRepository;

  UIState _state = UIState.initial();

  UIState get state => _state;

  List<StoryResponse> _storyList = [];

  List<StoryResponse> get storyList => _storyList;

  HomeProvider({
    required StoryRepository storyRepository,
  }) : _storyRepository = storyRepository;

  Future<void> getStoryList() async {
    _state = UIState.loading(message: "Loading...");
    notifyListeners();
    try {
      final storyListResponse = await _storyRepository.getStoryList();
      _storyList = storyListResponse.listStory;

      _state = UIState.success();
      notifyListeners();
    } catch (e) {
      _state = UIState.error(e.toString());
      notifyListeners();
    }
  }
}
