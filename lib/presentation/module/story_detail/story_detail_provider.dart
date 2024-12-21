import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:layar_cerita_app/data/repository/story_repository.dart';
import 'package:layar_cerita_app/data/source/network/response/story/story_detail_response.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';

import 'map_controller_mixin.dart';

class StoryDetailProvider extends ChangeNotifier with MapControllerMixin {
  final StoryRepository _storyRepository;

  UIState _state = UIState.initial();

  UIState get state => _state;

  StoryDetailResponse? _storyDetailResponse;

  StoryDetailResponse? get storyDetailResponse => _storyDetailResponse;

  StoryDetailProvider({required StoryRepository storyRepository})
      : _storyRepository = storyRepository;

  Future<void> getStoryDetail(String storyId) async {
    _state = UIState.loading(message: "Loading");
    notifyListeners();
    try {
      _storyDetailResponse = await _storyRepository.getStoryDetail(storyId);
      _state = UIState.success();
      notifyListeners();
    } catch (e) {
      _state = UIState.error(e.toString());
      notifyListeners();
    }
  }

  @override
  triggerNotifyListener() {
    notifyListeners();
  }
}
