import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:layar_cerita_app/data/repository/story_repository.dart';
import 'package:layar_cerita_app/data/source/network/response/story/story_response.dart';
import 'package:layar_cerita_app/utils/ui_state.dart';

class HomeProvider extends ChangeNotifier {
  final StoryRepository _storyRepository;

  UIState _state = UIState.initial();

  UIState get state => _state;

  List<StoryResponse> _storyList = [];

  List<StoryResponse> get storyList => _storyList;

  int? pageItems = 1;
  int sizeItems = 10;
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController(viewportFraction: 1);

  HomeProvider({
    required StoryRepository storyRepository,
  }) : _storyRepository = storyRepository;

  Future<void> getStoryList() async {
    try {

      if (pageItems == 1) {
        _state = UIState.loading(message: "Loading...");
        notifyListeners();
      }

      final storyListResponse = await _storyRepository.getPaginationStory(
        (pageItems ?? 0),
        sizeItems,
      );

      _storyList.addAll(storyListResponse.listStory);
      _state = UIState.success();

      if (storyListResponse.listStory.length < sizeItems) {
        pageItems = null;
      } else {
        pageItems = (pageItems ?? 0) + 1;
      }
      debugPrint("getStoryList, pageItems: $pageItems, sizeItems: $sizeItems");

      notifyListeners();
    } catch (e) {
      _state = UIState.error(e.toString());
      notifyListeners();
    }
  }
}
